//
//  PostStatusViewController.m
//  RenrenStatusClient
//
//  Created by Snowmanzzz on 14-1-17.
//  Copyright (c) 2014年 zzz. All rights reserved.
//

#import "PostStatusViewController.h"
#import "StatusListViewController.h"

@interface PostStatusViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *statusLabel;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *bb1;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *bb2;
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
    self.navigationItem.rightBarButtonItems = @[self.bb1, self.bb2];
    self.bb2.target = self;
    self.bb2.action = @selector(showStatusList);
}

- (void)showStatusList {
    // 教你透彻了解红黑树
    StatusListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"StatusList"];
    
    [self presentViewController:vc animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#import "Constants.h"
- (IBAction)done:(id)sender {
    
    NSString *status = self.statusLabel.text;
    
    NSMutableArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:STATUS_ARRAY];
    [array addObject:status];
    
    [[NSUserDefaults standardUserDefaults] setObject:status forKey:USER_STATUS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil) NSLog(@"notif creation failed!");
    NSDate *fireTime = [[NSDate date] addTimeInterval:((UISlider *)sender).value * 24 * 60 * 60]; // adds 10 secs
    localNotif.fireDate = fireTime;
    localNotif.alertBody = self.statusLabel.text;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
