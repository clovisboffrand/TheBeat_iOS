//
//  SocialPageViewController.m
//  WJRS
//
//  Created by admin_user on 3/7/16.
//
//

#import "SocialPageViewController.h"
#import "header.h"

@interface SocialPageViewController () <UIWebViewDelegate> {
    IBOutlet UIActivityIndicatorView *progress;
    IBOutlet UIWebView *webView;
}

@end

@implementation SocialPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [CommonHelpers backBarButtonItemWithTarget:self action:@selector(didTapBackButton:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.pageURL]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - WebView Delegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [progress startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [progress stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [progress stopAnimating];
}

#pragma mark - Button Action Methods

- (IBAction)didTapBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didTapGoBack:(id)sender {
    [webView goBack];
}

- (IBAction)didTapGoForward:(id)sender {
    [webView goForward];
}

- (IBAction)didTapReload:(id)sender {
    if (!progress.isAnimating) {
        [webView reload];
    }
}

@end
