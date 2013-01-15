//
//  PinDetailViewController.m
//  LDClickableAnnotation
//
//  Created by Tomek Janik on 1/13/13.
//  Copyright (c) 2013 Tomek Janik. All rights reserved.
//

#import "PinDetailViewController.h"

@interface PinDetailViewController ()

@end

@implementation PinDetailViewController

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
	[self.pinTitle setText:self.title];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
