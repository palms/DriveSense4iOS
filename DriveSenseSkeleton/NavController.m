//
//  NavController.m
//  DriveSense
//
//  Created by The Protagonist on 5/8/13.
//  Copyright (c) 2013 Group Eggo. All rights reserved.
//

#import "NavController.h"

@interface NavController ()

@end

@implementation NavController

@synthesize navBar;

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
    
    [self delete:navBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
