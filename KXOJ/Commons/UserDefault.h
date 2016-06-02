//
//  UserObject.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserDefault : NSObject <NSCoding>

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSDictionary *channelInfo;

@property (nonatomic, readonly) NSNumber *chanelID;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *cDescription;
@property (nonatomic, readonly) NSString *stream;
@property (nonatomic, readonly) NSString *tintColor;
@property (nonatomic, readonly) NSString *logo;
@property (nonatomic, readonly) BOOL streamAvailble;

+ (UserDefault *) user;
- (void) update;
+ (void) update;
+ (void) clearInfo;

@end
