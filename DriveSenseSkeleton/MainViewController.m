//
//  MainViewController.m
//  DriveSenseSkeleton
//
//  Created by The Protagonist on 3/12/13.
//  Copyright (c) 2013 Group Eggo. All rights reserved.
//

#import "MainViewController.h"
#import "Reachability.h"
#import "OptionsController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize trackingButton, mapButton, uploadButton, logo, autoCollectButton, trackSpeedButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
		
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = @"DriveSense iOS";
    
    NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval: 3 target: self selector: @selector (updateUploadButton) userInfo: nil repeats: YES];
    
    //[self checkForWIFIConnection];
    
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkBattery) name:@"UIDeviceBatteryStateDidChangeNotification" object:device];
    
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"black.png"]];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    
    self.logo.image = [UIImage imageNamed:@"car.png"];
    
    [trackingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mapButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [uploadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    geoLocation = [[NSMutableArray alloc] initWithCapacity:100];
    speed = [[NSMutableArray alloc] initWithCapacity:100];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];

    
    
    /*
    labelTxt.numberOfLines = 0;
    
    NSString *txt = @"DriveSense iOS beta - for testing  purposes only; does not represent a final version.";
    labelTxt.text = txt;
     */
}

-(void)updateUploadButton {
    if (uploadButtonStatus == true) {
        [uploadButton setTitle:@"Upload" forState:UIControlStateNormal];
        [uploadButton setTitleColor:nil forState:UIControlStateNormal];
    }
}

- (bool)checkBattery {
    if ([[UIDevice currentDevice] batteryState] == UIDeviceBatteryStateUnknown) {
        return true;
        //for the time being
    }
    else {
        if ([[UIDevice currentDevice] batteryState] == UIDeviceBatteryStateUnplugged) {
            return false;
            
        }
    }
    return true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    if (manualToggle == true) {
        CLLocation *location = [locations objectAtIndex:0];
        NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
        //add geodata to NSMutable Array
        [geoLocation addObject:location];
        if (trackSpeedOn == true) {
            double gpsSpeed = location.speed;
            NSLog(@"speed:%f", gpsSpeed);
        }
    }
    
    if (autoCollectOn == true) {
        CLLocation *location = [locations objectAtIndex:0];
        NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
        //add geodata to NSMutable Array
        [geoLocation addObject:location];
        if (trackSpeedOn == true) {
            double gpsSpeed = location.speed;
            NSLog(@"speed:%f", gpsSpeed);
        }
    }
    
    /*
     CLLocationCoordinate2D coordinate;
     coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
     
     MKCoordinateSpan span = {.latitudeDelta =  0.2, .longitudeDelta =  0.2};
     MKCoordinateRegion region = {coordinate, span};
     [mapView setRegion:region];
     
     MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
     annotation.coordinate = coordinate;
     annotation.title = @"Location";
     */
}
- (IBAction)track:(id)sender {
    
    if (manualToggle == false) {
        manualToggle = true;
        [trackingButton setTitle:@"Now Tracking" forState:UIControlStateNormal];
        [trackingButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
    }
    else {
        manualToggle = false;
        [trackingButton setTitle:@"Track" forState:UIControlStateNormal];
        [trackingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (IBAction)upload:(id)sender {
    //if wifi detected, upload
    //if not, error message
    
    Reachability* wifiReach = [Reachability reachabilityForLocalWiFi];
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    if (netStatus!=ReachableViaWiFi) {
        [uploadButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //double delaySec = 2.0;
        //dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delaySec * NSEC_PER_SEC);
        //dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [uploadButton setTitle:@"No WIFI!" forState:UIControlStateNormal];
        [uploadButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //});
        uploadButtonStatus = true;
    }
    else {
        [uploadButton setTitle:@"Uploading..." forState:UIControlStateNormal];
        [uploadButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }

}

/*
- (void)checkForWIFIConnection {
    Reachability* wifiReach = [Reachability reachabilityForLocalWiFi];
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    if (netStatus!=ReachableViaWiFi) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No WIFI available!", @"AlertView")
            message:NSLocalizedString(@"You have no wifi connection available. Please connect to a WIFI network.", @"AlertView")
                delegate:self
                    cancelButtonTitle:NSLocalizedString(@"Cancel", @"AlertView")
                    otherButtonTitles:NSLocalizedString(@"Open settings", @"AlertView"), nil];
        [alertView show];
    }
}
*/
- (IBAction)autoCollectPress:(id)sender {
    
    if (autoCollectOn == false) {
        
        UIDevice *device = [UIDevice currentDevice];
        device.batteryMonitoringEnabled = YES;
        
        bool batteryStatus = [self checkBattery];
        
        if (batteryStatus == true) {
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryStatusCheck) name:@"UIDeviceBatteryStateDidChangeNotification" object:device];
            
            //signal button pressed, tracking
            [trackingButton setEnabled: NO];
            [trackingButton setTitle:@"Disabled" forState:UIControlStateNormal];
            [trackingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [trackingButton setBackgroundColor:[UIColor redColor]];
            [trackingButton setAlpha:0.42];
            
            autoCollectOn = true;
            autoCollectButton.tintColor = [UIColor greenColor];
        }
        
        else {
            device.batteryMonitoringEnabled = NO;
        }
    }
    else {
        //signal button unpressing, stop tracking
        
        [trackingButton setEnabled: YES];
        [trackingButton setTitle:@"Track" forState:UIControlStateNormal];
        [trackingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [trackingButton setBackgroundColor:nil];
        [trackingButton setAlpha:1];
        
        UIDevice *device = [UIDevice currentDevice];
        device.batteryMonitoringEnabled = NO;
        
        autoCollectOn = false;
        autoCollectButton.tintColor = nil;
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"OptionsSegue"])
    {
        OptionsController *options = [segue destinationViewController];
        options->autoCollectOn = self->autoCollectOn;
    }
}

/*
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    CLLocationDirection trueNorth = [newHeading trueHeading];
    
    CLLocationDirection magnetic = [newHeading magneticHeading];
    
}
*/
- (IBAction)trackSpeedPress:(id)sender {
    if (trackSpeedOn == false) {
        trackSpeedOn = true;
        trackSpeedButton.tintColor = [UIColor greenColor];
        
    }
    else {
        trackSpeedOn = false;
        trackSpeedButton.tintColor = nil;
    }
}

-(void)batteryStatusCheck {
    bool status = [self checkBattery];
    if (status == false) {
        
        [trackingButton setEnabled: YES];
        [trackingButton setTitle:@"Track" forState:UIControlStateNormal];
        [trackingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [trackingButton setBackgroundColor:nil];
        [trackingButton setAlpha:1];
        
        UIDevice *device = [UIDevice currentDevice];
        device.batteryMonitoringEnabled = NO;
        
        autoCollectOn = false;
        autoCollectButton.tintColor = nil;
    }
}

@end
