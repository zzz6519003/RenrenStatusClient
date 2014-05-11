//
//  LoginViewController.m
//  RenrenStatusClient
//
//  Created by Snowmanzzz on 5/11/14.
//  Copyright (c) 2014 zzz. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"

@interface LoginViewController () <UIWebViewDelegate>

@end

@implementation LoginViewController

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
    // Do any additional setup after loading the view from its nib.
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    [webView loadHTMLString:nil baseURL:[NSURL URLWithString:@"http://graph.renren.com/oauth/grant?client_id=fee11992a4ac4caabfca7800d233f814&redirect_uri=http%3A%2F%2Fgraph.renren.com%2Foauth%2Flogin_success.html&response_type=token&display=page&secure=true&origin=00000"]];
    //@"http://graph.renren.com/oauth/grant?client_id=fee11992a4ac4caabfca7800d233f814&redirect_uri=http%3A%2F%2Fgraph.renren.com%2Foauth%2Flogin_success.html&response_type=token&display=page&secure=true&origin=00000"
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://graph.renren.com/oauth/grant?client_id=fee11992a4ac4caabfca7800d233f814&redirect_uri=http%3A%2F%2Fgraph.renren.com%2Foauth%2Flogin_success.html&response_type=token&display=page&secure=true&origin=00000&scope=read_user_feed+publish_comment"]]];
    [self.view addSubview:webView];
    webView.delegate = self;
//    webView.paginationMode = UIWebPaginationModeBottomToTop;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    UIScrollView *sv = [UIScrollView alloc] initWith
    
    //http://graph.renren.com/oauth/login_success.html#access_token=127089%7C6.e2644844beecbcb8daa7cbefee32b1fd.2592000.1402376400-279838227&expires_in=2594648
    NSString *a = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    NSArray *array = [a componentsSeparatedByString:@"access_token="];
    if ([array count] >= 2) {
        NSArray *array2 = [array[1] componentsSeparatedByString:@"&expires_in"];
        if ([array2 count] >= 2) {
            NSString *str = array2[0];
            str = [str stringByRemovingPercentEncoding];
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:TOKEN_KEY];
            [[NSUserDefaults standardUserDefaults] synchronize];

        }
    }
    NSLog(a);
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
//    NSLog(@"d");
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
////    request.URL
////    access_token=
//    return YES;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
