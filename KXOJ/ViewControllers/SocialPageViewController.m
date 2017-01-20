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
    [self hideHeaderScript];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [progress stopAnimating];
    [self hideHeaderScript];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [progress stopAnimating];
    [self hideHeaderScript];
}

#pragma mark - Button Action Methods

- (void)didTapBackButton:(id)sender {
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

#pragma mark - Other

/// hiding page header (app rejection issue)
- (void)hideHeaderScript {
    NSString *script = [NSString stringWithFormat:@"document.getElementById(\"header-wrapper\").style.display='none';"];
    [webView stringByEvaluatingJavaScriptFromString:script];
}

@end
