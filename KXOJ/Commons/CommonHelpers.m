//
//  CommonHelpers.m
//  iRadio
//
//  Created by Phuc Tran on 2/9/14.
//
//

#import "CommonHelpers.h"
#import "Header.h"

@implementation CommonHelpers

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize {
    
    float width = newSize.width;
    float height = newSize.height;
    
    UIGraphicsBeginImageContext(newSize);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height;
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    width = image.size.width / divisor;
    height = image.size.height / divisor;
    
    rect.size.width  = width;
    rect.size.height = height;
    
    //indent in case of width or height difference
    float offset = (width - height) / 2;
    if (offset > 0) {
        rect.origin.y = offset;
    }
    else {
        rect.origin.x = -offset;
    }
    
    [image drawInRect: rect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return smallImage;
    
}

+ (AFHTTPRequestOperationManager *)HTTPRequestOperationManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];
    manager.responseSerializer = [AFXMLParserResponseSerializer new];
    return manager;
}

+ (UIImage *)imageSplashScreen
{
    NSString *path ;
    if(UIDeviceModelIsIphone4())
    {
        path = @"splash640x960";
    }
    else
    {
        path = @"splash640x1136";
    }
    return [UIImage imageNamed:path];
}

+ (NSString *)HTMLBodyOfBannerView
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"iframe" ofType:@"html"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    string  = [string stringByReplacingOccurrencesOfString:@"#width#"
                                                withString:[NSString stringWithFormat:@"%f", window.frame.size.width]];
    return string;
}

+ (UIBarButtonItem *)backBarButtonItemWithTarget:(id)tagert action:(SEL)seletor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 34, 25);
    button.backgroundColor  = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [button setBackgroundImageTintColor:[UIColor whiteColor]];
    [button addTarget:tagert action:seletor forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

+ (UIBarButtonItem *)cancelBarButtonItemWithTarget:(id)tagert action:(SEL)seletor
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:tagert action:seletor];
    item.tintColor=[UIColor whiteColor];
    return item;
}

@end
