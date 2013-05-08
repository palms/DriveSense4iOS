//
//  OptionsController.m
//  DriveSense
//
//  Created by The Protagonist on 5/7/13.
//  Copyright (c) 2013 Group Eggo. All rights reserved.
//

#import "OptionsController.h"
#import "MainViewController.h"

@interface OptionsController ()

@end

@implementation OptionsController

@synthesize items;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    
    /*
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.jpg"]];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
     */
    
    self.items = [NSArray arrayWithObjects:@"Auto Collect",@"Use GPS Tracking", @"Direction Sensor", @"Speed Sensor",nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"OptionCells";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    if (indexPath.row != 1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"OptionsToMain"])
    {
        MainViewController *mV = [segue destinationViewController];
        mV->autoCollectOn = self->autoCollectOn;
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellTxt = cell.textLabel.text;
    
    if ([cellTxt isEqualToString:[items objectAtIndex:0]]) {
        if (autoCollectOn == false) {
            
            UIDevice *device = [UIDevice currentDevice];
            device.batteryMonitoringEnabled = YES;
            
            bool batteryStatus = [self checkBattery];
            
            if (batteryStatus == true) {
            
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkBattery) name:@"UIDeviceBatteryStateDidChangeNotification" object:device];
            
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                autoCollectOn = true;
            }
            
            else {
                device.batteryMonitoringEnabled = NO;
                cell.textLabel.textColor = [UIColor redColor];
            }
        }
        else {
             cell.accessoryType = UITableViewCellAccessoryNone;
            
            UIDevice *device = [UIDevice currentDevice];
            device.batteryMonitoringEnabled = NO;
            
            autoCollectOn = false;
        }
        // autocollect
        //[self performSegueWithIdentifier:@"ShowCaption" sender:self];
    }
    else if ([cellTxt isEqualToString:[items objectAtIndex:1]]) {
        //gps tracking
        //[self performSegueWithIdentifier:@"ShowTags" sender:self];
    }
    else if ([cellTxt isEqualToString:[items objectAtIndex:2]]) {
        //direction sensor
        //[self performSegueWithIdentifier:@"ShowLikes" sender:self];
    }
    else {
        //speed sensor
        //[self performSegueWithIdentifier:@"ShowLocation" sender:self];
    }
}

- (bool)checkBattery {
    if ([[UIDevice currentDevice] batteryState] == UIDeviceBatteryStateUnknown) {
        return true;
    }
    else {
        if ([[UIDevice currentDevice] batteryState] == UIDeviceBatteryStateUnplugged) {
            return false;
        }
    }
    return true;
}

@end
