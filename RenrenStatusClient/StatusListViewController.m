//
//  StatusListViewController.m
//  RenrenStatusClient
//
//  Created by Snowmanzzz on 14-2-18.
//  Copyright (c) 2014年 zzz. All rights reserved.
//

#import "StatusListViewController.h"

@interface StatusListViewController ()

@end

@implementation StatusListViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
