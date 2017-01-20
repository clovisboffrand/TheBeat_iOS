//
//  WebViewController.m
//  WJRS
//
//  Created by admin_user on 3/7/16.
//
//

#import "WebViewController.h"
#import "Header.h"

@interface WebViewController () <UIWebViewDelegate>
{
    IBOutlet UIWebView *adWebView;
    IBOutlet UIWebView *mainWebView;
    IBOutlet UIActivityIndicatorView *progress;
}

@end

#define WEB_URL @"http://bristolbeat.com/category/events/"

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBanner];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WEB_URL]]];
}

#pragma mark - Setup Banner View

- (void)addBanner {
    [adWebView loadHTMLString:[CommonHelpers HTMLBodyOfBannerView] baseURL:nil];
    adWebView.scrollView.scrollEnabled = NO;
}

#pragma mark - WebView Delegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if ([webView isEqual:mainWebView]) {
        [progress startAnimating];
        [self hideHeaderScript];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([webView isEqual:mainWebView]) {
        [progress stopAnimating];
        [self hideHeaderScript];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if ([webView isEqual:mainWebView]) {
        [progress stopAnimating];
        [self hideHeaderScript];
    }
}

#pragma mark - WebView Delegate Methods

- (BOOL)webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if (inWeb == adWebView) {
        if (inType == UIWebViewNavigationTypeLinkClicked) {
            [[UIApplication sharedApplication] openURL:[inRequest URL]];
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Button Action Methods

- (IBAction)didTapGoBack:(id)sender {
    [mainWebView goBack];
}

- (IBAction)didTapGoForward:(id)sender {
    [mainWebView goForward];
}

- (IBAction)didTapReload:(id)sender {
    if (!progress.isAnimating) {
        [mainWebView reload];
    }
}

#pragma mark - Other

/// hiding page header (app rejection issue)
- (void)hideHeaderScript {
    NSString *script = [NSString stringWithFormat:@"document.getElementById(\"header-wrapper\").style.display='none';"];
    [mainWebView stringByEvaluatingJavaScriptFromString:script];
}

@end
