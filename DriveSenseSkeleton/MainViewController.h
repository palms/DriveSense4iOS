//
//  MainViewController.h
//  DriveSenseSkeleton
//
//  Created by The Protagonist on 3/12/13.
//  Copyright (c) 2013 Group Eggo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DBAdapter.h"

@interface MainViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    bool manualToggle;
    NSMutableArray *geoLocation;
    NSMutableArray *speed;
    
    @public
    bool autoCollectOn;
    bool trackSpeedOn;
    bool uploadButtonStatus;
}



@property (strong, nonatomic) IBOutlet UIButton *trackingButton;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;
@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *autoCollectButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *trackSpeedButton;
@property (strong, nonatomic) DBAdapter *adapter;


@end
