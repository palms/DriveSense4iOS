//
//  DBAdapter.m
//  DriveSense
//
//  Created by John Terrill on 5/8/13.
//  Copyright (c) 2013 Group Eggo. All rights reserved.
//

#import "DBAdapter.h"

@interface DBAdapter ()

@end

@implementation DBAdapter

- (void) openDB {
    // creating database and tables
    NSString *docsDir;
    NSArray *dirPaths;
    
    // currently gets the documents directory! don't know how to search for something else. need some help here
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    //building path to database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"locations.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //opening database or creating one if none exists
    if ([filemgr fileExistsAtPath:databasePath]) {
        
        //path name has to be converted into UTF8 to be read by SQLite
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &locationsDB) == SQLITE_OK) {
            //im creating a table here called locations
            //REAL at the end of latitude and longitude means im storing them as doubles
            //and the Autoincrement is numbering the additions into the table
            const char *sql_createStmt = "CREATE TABLE IF NOT EXISTS LOCATIONS (ID INTEGER PRIMARY KEY AUTOINCREMENT, LATITUDE REAL, LONGITUDE REAL, SPEED REAL)";
            
            if (sqlite3_exec(locationsDB, sql_createStmt, NULL, NULL, NULL) != SQLITE_OK) {
                NSLog(@"table not created");
            }
        }
        else {
            NSLog(@"database failed to create");
        }
    }
}

- (void) insertObject:(CLLocation*)locationObject {
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &locationsDB) == SQLITE_OK) {
        
        //i'm pretty sure this will work but didUpdateToLocation isn't running on the simulation so i don't know how to test it
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO LOCATIONS (LATITUDE, LONGITUDE, SPEED) VALUES (\"%f\", \"%f\", \"%f\")", locationObject.coordinate.latitude, locationObject.coordinate.longitude, locationObject.speed];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(locationsDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"it worked!");
            
        }
        else {
            NSLog(@"data not added correctly into sqlite!");
        }
        sqlite3_finalize(statement);
    }
}

- (void) closeDB {
    sqlite3_close(locationsDB);
}

@end
