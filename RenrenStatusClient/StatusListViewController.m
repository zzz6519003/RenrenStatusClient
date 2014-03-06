//
//  StatusListViewController.m
//  RenrenStatusClient
//
//  Created by Snowmanzzz on 14-2-18.
//  Copyright (c) 2014年 zzz. All rights reserved.
//

#import "StatusListViewController.h"
#import "Constants.h"

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
    
    NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:STATUS_ARRAY];
    self.statusArray = arr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.statusArray forKey:STATUS_ARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StatusCell"];
    if (!cell) {
        NSLog(@"wo cao!");
    }
    cell.textLabel.text = self.statusArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id a = @[@"1"];
    return self.statusArray.count;
}


@end
