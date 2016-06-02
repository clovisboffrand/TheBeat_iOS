//
//  UserObject.m
//
//
#define kUserDefault_Acc @"User_App"
#import "UserDefault.h"
#import "Define.h"
#import "Header.h"

@interface UserDefault () <UIAlertViewDelegate>

@end

static UserDefault *globalObject;

@implementation UserDefault

#pragma mark - InstanceType

- (id)initWithId:(NSInteger)userID
{
    self.userID = [NSString stringWithFormat:@"%ld", (long)userID];
    return self;
}

- (BOOL) isLogin
{
    return _userID.integerValue > 0;
}

- (NSNumber *) chanelID
{
    return _channelInfo[@"id"];
}

- (NSString *) title
{
    return _channelInfo[@"title"];
}

- (NSString *) stream
{
    return _channelInfo[@"stream"];
}

- (NSString *) tintColor
{
    return _channelInfo[@"color"];
}

- (NSString *) cDescription
{
    return _channelInfo[@"description"];
}

- (NSString *) logo
{
    return _channelInfo[@"logo"];
}

- (BOOL) streamAvailble
{
    return _channelInfo[@"stream"];
}

#pragma mark - NSCoder
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.userID         = [aDecoder decodeObjectForKey:@"id_user"];
        self.channelInfo       = [aDecoder decodeObjectForKey:@"channelInfo"];
    }
    return self;    
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userID forKey:@"id_user"];
    [aCoder encodeObject:self.channelInfo forKey:@"channelInfo"];
}

- (void) updateUserDefault
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSKeyedArchiver archivedDataWithRootObject:self] forKey:kUserDefault_Acc];
    [userDefault synchronize];
}

+ (void) clearInfo{
    UserDefault *user   = [UserDefault user];
    user.userID         = nil;
    [user update];
}

+ (UserDefault *) user
{
    if (!globalObject) {
       
#if __has_feature(objc_arc)
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        globalObject = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefault dataForKey:kUserDefault_Acc]] ;
        if (!globalObject) {
            globalObject = [[UserDefault alloc] init] ;
            [globalObject update];
        }
#else
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        globalObject = [[NSKeyedUnarchiver unarchiveObjectWithData:[userDefault dataForKey:kUserDefault_Acc]] retain];
        if (!globalObject) {
            globalObject = [[[UserDefault alloc] init] retain];
            [globalObject update];
        }
#endif
    }
    
    return globalObject;
}
- (void) update
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSKeyedArchiver archivedDataWithRootObject:self] 
                    forKey:kUserDefault_Acc];
    [userDefault synchronize];
}

+ (void) update
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSKeyedArchiver archivedDataWithRootObject:globalObject] 
                    forKey:kUserDefault_Acc];
    [userDefault synchronize];
}

-(void)dealloc
{
#if !(__has_feature(objc_arc))
    [super dealloc];
#endif
}

@end


