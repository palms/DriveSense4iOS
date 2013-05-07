//
//  MainViewController.m
//  DriveSenseSkeleton
//
//  Created by The Protagonist on 3/12/13.
//  Copyright (c) 2013 Group Eggo. All rights reserved.
//

#import "MainViewController.h"
#import "Reachability.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize labelTxt, trackingButton, mapButton, uploadButton;

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
    
    //[self checkForWIFIConnection];
    
    autoCollectOn = false;
    
    
    
    manualToggle = false;
    [trackingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mapButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [uploadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    geoLocation = [[NSMutableArray alloc] initWithCapacity:100];
    
    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f/60.0f;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)accelerometer:(UIAccelerometer *)acel didAccelerate:(UIAcceleration *)aceler
{
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations objectAtIndex:0];
    NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
    
    if (manualToggle == true) {
        //add geodata to NSMutable Array
        [geoLocation addObject:location];
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
        [uploadButton setTitle:@"No WIFI!" forState:UIControlStateNormal];
        [uploadButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
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

@end
