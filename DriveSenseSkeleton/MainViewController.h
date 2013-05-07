//
//  MainViewController.h
//  DriveSenseSkeleton
//
//  Created by The Protagonist on 3/12/13.
//  Copyright (c) 2013 Group Eggo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MainViewController : UIViewController <CLLocationManagerDelegate, UIAccelerometerDelegate>
{
    CLLocationManager *locationManager;
    bool manualToggle;
    NSMutableArray *geoLocation;
    bool autoCollectOn;
    bool gpsTrackingOn;
}


@property (strong, nonatomic) IBOutlet UILabel *labelTxt;
@property (strong, nonatomic) IBOutlet UIButton *trackingButton;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;

@end
