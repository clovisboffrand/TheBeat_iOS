//
//  WebViewController.m
//  WJRS
//
//  Created by admin_user on 3/7/16.
//
//

#import "WebViewController.h"
#import "Header.h"

@interface WebViewController () <UIWebViewDelegate> {
    IBOutlet UIWebView *adWebView;
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *progress;
}

@end

#define WEB_URL @"http://www.987thesong.com"

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Load web page from url.
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WEB_URL]]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    GoogleTrackingBlock(self, CLASS_VC);
}

#pragma mark - Setup Banner View

- (void)addBanner {
    [adWebView loadHTMLString:[CommonHelpers HTMLBodyOfBannerView] baseURL:nil];
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
