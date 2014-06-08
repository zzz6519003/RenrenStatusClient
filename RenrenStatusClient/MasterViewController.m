//
//  MasterViewController.m
//  RenrenStatusClient
//
//  Created by Snowmanzzz on 14-1-9.
//  Copyright (c) 2014年 zzz. All rights reserved.
//

#import "MasterViewController.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "DetailViewController.h"
#import "TSMessage.h"
#import "AMWaveTransition.h"
#import "LoginViewController.h"


@interface MasterViewController () {
    NSMutableArray *_objects;
    int pageNumber;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)refresh {
    pageNumber = 1;
    NSString *url = [NSString stringWithFormat:@"https://api.renren.com/v2/feed/list?access_token=%@&feedType=UPDATE_STATUS&pageSize=100&pageNumber=%d",TOKEN, pageNumber];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.refreshControl endRefreshing];
        NSLog(@"%@", responseObject);
        _objects = responseObject[@"response"];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.refreshControl endRefreshing];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [TSMessage showNotificationWithTitle:@"This is just for fun, so it's Buggy~ Enjoy!" subtitle:nil type:TSMessageNotificationTypeMessage]; canBeDismisedByUser:<#(BOOL)#>];
//    UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:@"This is just for fun, so it's Buggy~ Enjoy! 享受Bug吧!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//    [al show];
    [TSMessage showNotificationInViewController:self.navigationController title:@"This is just for fun, so it's Buggy~ Enjoy! 享受Bug吧!我的人人网是:赵正中 .m" subtitle:nil type:TSMessageNotificationTypeSuccess];
    [TSMessage showNotificationInViewController:self.navigationController title:@"话说我还不确定是否要在人人那审核一次，如果你们登录后还刷新不出内容就在人人上跟我说吧~" subtitle:nil type:TSMessageNotificationTypeSuccess];
    
    self.title = @"RenRen";
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl = refreshControl;
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    pageNumber = 1;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Load more" style:UIBarButtonItemStylePlain target:self action:@selector(loadMore:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Log in" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    self.navigationItem.leftBarButtonItem = loginButton;
    
    NSString *url = [NSString stringWithFormat:@"https://api.renren.com/v2/feed/list?access_token=%@&feedType=UPDATE_STATUS&pageSize=100", TOKEN];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        _objects = responseObject[@"response"];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
//    [self.navigationController.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
//    [self.view setBackgroundColor:[UIColor clearColor]];
//    [self.tableView setBackgroundColor:[UIColor clearColor]];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMore:(id)sender
{
    pageNumber++;
    NSString *url = [NSString stringWithFormat:@"https://api.renren.com/v2/feed/list?access_token=%@&feedType=UPDATE_STATUS&pageSize=100&pageNumber=%d", TOKEN, pageNumber];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *a = [_objects mutableCopy];
        [a  addObjectsFromArray:responseObject[@"response"]];
        _objects = a;
        [self.tableView reloadData];
    } failure:nil];

//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)login {
    LoginViewController *lvc = [[LoginViewController alloc] init];
    UINavigationController *uin = [[UINavigationController alloc] initWithRootViewController:lvc];

    UIBarButtonItem *bn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismiss)];
    [lvc.navigationItem setLeftBarButtonItem:bn animated:YES];

    [self presentViewController:uin animated:YES completion:nil];
//    afnet
//    [RennAccessToken
//    [RennClient initWithAppId:@"246550" apiKey:@"8efd8d438db6430ba01aadfd0d1eab3e" secretKey:@"01ba93ef63bb4769a09649b6ab1cbcd8"];
//    [RennClient setScope:@"read_user_feed read_user_blog read_user_photo read_user_status read_user_album read_user_comment read_user_share publish_blog publish_share send_notification photo_upload status_update create_album publish_comment publish_feed operate_like"];

//    [RennClient loginWithDelegate:self];
    
}

- (void)rennLoginSuccess {
//    [[NSUserDefaults standardUserDefaults] setObject:[RennClient accessToken].accessToken forKey:TOKEN_KEY];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor clearColor]];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.tag = indexPath.row;
    [btn addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
    //TODO
//    [cell addSubview:btn];
    cell.detailTextLabel.text = _objects[indexPath.row][@"resource"][@"content"];
    cell.textLabel.text = _objects[indexPath.row][@"sourceUser"][@"name"];
    return cell;
}

- (void)like:(UIView *)sender {
    NSInteger row = sender.tag;
    NSString *Xid = _objects[row][@"id"];
    NSString *sourceUserId = _objects[row][@"sourceUser"][@"id"];
    NSDictionary *parameters = @{@"ugcOwnerId": sourceUserId, @"ugcId": Xid, @"LikeUGCType" : @"TYPE_STATUS"};

    NSString *url = [NSString stringWithFormat:@"https://api.renren.com/v2/like/ugc/put?access_token=%@", TOKEN];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        _objects = responseObject[@"response"];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    if (operation != UINavigationControllerOperationNone) {
        return [AMWaveTransition transitionWithOperation:operation];
    }
    return nil;
}

- (NSArray*)visibleCells
{
    return [self.tableView visibleCells];
}

- (void)dealloc
{
    [self.navigationController setDelegate:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.;
}

@end
