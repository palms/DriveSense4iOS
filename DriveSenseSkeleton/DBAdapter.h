//
//  DBAdapter.h
//  DriveSense
//
//  Created by John Terrill on 5/8/13.
//  Copyright (c) 2013 Group Eggo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import <CoreLocation/CoreLocation.h>

@interface DBAdapter : NSObject
{
    sqlite3 *locationsDB;
    NSString *databasePath;
}
- (void) openDB;
- (void) insertObject:(CLLocation*)locationObject;
- (void) closeDB;
@end
