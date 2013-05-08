//
//  MapViewController.m
//  DriveSenseSkeleton
//
//  Created by Saul Laufer on 3/12/13.
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
    
    [self centerLoc];
    
    mapView.delegate = self; 
    
    mapView.showsUserLocation = YES;
    
    
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MKMapTypeHybrid;
    
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

-(void)centerLoc {
    [mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];

}

@end
