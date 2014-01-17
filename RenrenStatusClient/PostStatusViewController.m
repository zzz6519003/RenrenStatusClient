//
//  PostStatusViewController.m
//  RenrenStatusClient
//
//  Created by Snowmanzzz on 14-1-17.
//  Copyright (c) 2014年 zzz. All rights reserved.
//

#import "PostStatusViewController.h"

@interface PostStatusViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *statusLabel;

@end

@implementation PostStatusViewController

- (IBAction)timeChanged:(id)sender {
    self.timeLabel.text = [NSString stringWithFormat:@"%f", ((UISlider *)sender).value * 24];
}

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

- (IBAction)done:(id)sender {
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil) NSLog(@"notif creation failed!");
    NSDate *fireTime = [[NSDate date] addTimeInterval:((UISlider *)sender).value * 24 * 60 * 60]; // adds 10 secs
    localNotif.fireDate = fireTime;
    localNotif.alertBody = self.statusLabel.text;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];

}
@end
