//
//  DetailViewController.m
//  RenrenStatusClient
//
//  Created by Snowmanzzz on 14-1-9.
//  Copyright (c) 2014年 zzz. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "TSMessage.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *replyContent;

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
        self.detailDescriptionLabel.text = self.detailItem[@"resource"][@"content"];
        self.commentsArray = self.detailItem[@"comments"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reviewCannon:(id)sender {
    for (int i = 0; i < 10000; i++) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"content": @"mini 评论炮", @"commentType": @"STATUS", @"entryOwnerId" : _detailItem[@"sourceUser"][@"id"], @"entryId": _detailItem[@"resource"][@"id"]};
        NSString *url = [NSString stringWithFormat:@"https://api.renren.com/v2/comment/put?access_token=195797|6.8492fbb89ad82a9a9c8f12f16e482e7d.2592000.1391914800-279838227"];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

- (IBAction)review:(id)sender {
    [self.view endEditing:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"content": self.replyContent.text, @"commentType": @"STATUS", @"entryOwnerId" : _detailItem[@"sourceUser"][@"id"], @"entryId": _detailItem[@"resource"][@"id"]};
    NSString *url = [NSString stringWithFormat:@"https://api.renren.com/v2/comment/put?access_token=%@", TOKEN];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [TSMessage showNotificationWithTitle:@"Success!" type:TSMessageNotificationTypeSuccess];
        [TSMessage showNotificationInViewController:self.navigationController title:@"Success!" subtitle:nil type:TSMessageNotificationTypeSuccess];
        self.replyContent.text = @"";
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [TSMessage showNotificationWithTitle:@"Fail" type:TSMessageNotificationTypeError];
        [TSMessage showNotificationInViewController:self.navigationController title:@"Fail" subtitle:nil type:TSMessageNotificationTypeError];

        NSLog(@"Error: %@", error);
    }];

}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float height = keyboardFrame.size.height;

    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -height);
    }];
    //Assign new frame to your view

//    [self.view setFrame:CGRectMake(0, -height + 20, 320, 460)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.1 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return self.detailDescriptionLabel;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (![self.commentsArray isKindOfClass:[NSNull class]]) {
    return [self.commentsArray count];
    }
    else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"commentCell"];
    cell.detailTextLabel.text = self.commentsArray[indexPath.row][@"content"];
    cell.textLabel.text = self.commentsArray[indexPath.row][@"author"][@"name"];
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


@end
