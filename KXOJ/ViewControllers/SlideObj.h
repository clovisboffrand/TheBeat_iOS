//
//  SlideObj.h
//  WJRS
//
//  Created by admin_user on 3/7/16.
//
//

#import <Foundation/Foundation.h>

@interface SlideObj : NSObject

@property (nonatomic, assign) NSInteger slideID;
@property (nonatomic, strong) NSString *slideImageURL;
@property (nonatomic, strong) NSString *slideLinkURL;
@property (nonatomic, strong) NSString *slideCaption;

@end
