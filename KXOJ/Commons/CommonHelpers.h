//
//  CommonHelpers.h
//  iRadio
//
//  Created by Phuc Tran on 2/9/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AFHTTPRequestOperationManager;

@interface CommonHelpers : NSObject

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize;

+ (AFHTTPRequestOperationManager *)HTTPRequestOperationManager;

+ (UIImage *)imageSplashScreen;

+ (NSString *)HTMLBodyOfBannerView;

+ (UIBarButtonItem *)backBarButtonItemWithTarget:(id)tagert action:(SEL)seletor;

+ (UIBarButtonItem *)cancelBarButtonItemWithTarget:(id)tagert action:(SEL)seletor;

@end
