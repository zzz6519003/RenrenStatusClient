//
//  DetailViewController.m
//  RenrenStatusClient
//
//  Created by Snowmanzzz on 14-1-9.
//  Copyright (c) 2014年 zzz. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"

@interface DetailViewController ()

- (void)configureView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *commentContent;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)review:(id)sender {
//    NSString *url = [NSString stringWithFormat:@"https://api.renren.com/v2/feed/list?access_token=195797|6.8492fbb89ad82a9a9c8f12f16e482e7d.2592000.1391914800-279838227"];
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"content": @"test", @"commentType": @"STATUS", @"entryOwnerId" : _detailItem[@"sourceUser"][@"id"], @"entryId": _detailItem[@"resource"][@"id"]};
    NSString *url = [NSString stringWithFormat:@"https://api.renren.com/v2/comment/put?access_token=195797|6.8492fbb89ad82a9a9c8f12f16e482e7d.2592000.1391914800-279838227"];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];


}

@end
