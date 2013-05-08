//
//  OptionsController.h
//  DriveSense
//
//  Created by The Protagonist on 5/7/13.
//  Copyright (c) 2013 Group Eggo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionsController : UITableViewController {
    
    @public
    bool autoCollectOn;
    bool gpsTrackingOn;
}

@property (nonatomic, strong) NSArray *items;

@end
