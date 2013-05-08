//
//  MapViewController.h
//  DriveSenseSkeleton
//
//  Created by Saul Laufer on 3/12/13.
//  Copyright (c) 2013 Group Eggo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    MKMapView *mapView;
    UIToolbar *toolBar;
    UIToolbar *toolbar;
    bool manualToggle;
    NSMutableArray *geoLocation;
    BOOL ManualTracking;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
