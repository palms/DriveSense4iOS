//
//  MapViewController.m
//  DriveSenseSkeleton
//
//  Created by The Protagonist on 3/12/13.
//  Copyright (c) 2013 Group Eggo. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView;

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
    
    //init loc data array with arbitrary value
    
    mapView.delegate = self; 
    
    mapView.showsUserLocation = YES;
    
    
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MKMapTypeHybrid;
    
        /*
        CLLocationCoordinate2D coordinate;
        coordinate = CLLocationCoordinate2DMake([[locationInfo objectForKey:@"latitude"] floatValue], [[locationInfo objectForKey:@"longitude"] floatValue]);
        
        
        
        NSString *lat = [NSString stringWithFormat:@"%@",[locationInfo objectForKey:@"latitude"]];
        NSString *longi = [NSString stringWithFormat:@"%@",[locationInfo objectForKey:@"longitude"]];
        lat = [lat stringByAppendingString:@", "];
        lat = [lat stringByAppendingString:longi];
        annotation.subtitle = lat;
        [mapView addAnnotation:annotation];
        
        [self.view addSubview:mapView];
         
         */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation: (MKUserLocation *)userLocation
{
    self.mapView.centerCoordinate = userLocation.location.coordinate;
}

@end
