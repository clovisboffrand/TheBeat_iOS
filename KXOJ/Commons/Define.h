//
//  Define.h
//  OG23
//
//  Created by HarryTran on 10/29/13.
//  Copyright (c) 2013 BPT Softs. All rights reserved.
//

//#if defined __arm__ || defined __thumb__
//#undef TARGET_IPHONE_SIMULATOR
//#define TARGET_OS_IPHONE
//#else
//#define TARGET_IPHONE_SIMULATOR 1
//#undef TARGET_OS_IPHONE
//#endif

#undef  NSLocalizedString

#define NSLocalizedString(key, comment)  NSLocalizedStringCustom(key, comment)

#define CLASS_VC NSStringFromClass([self class])

#define kFB_APP_ID                  @"1447999118787441"

#define kGoogle_Tracking_ID         @"UA-42428688-13"

#define APP_NAME                    @"Bolsa Chica"

#define DATE_FORMAT_LONG_SERVER     @"yyyy-MM-dd HH:mm:ss"

#define DATE_FORMAT_SHORT_SERVER    @"yyyy-MM-dd"

#define DATE_FORMAT_USE_SC          @"dd/MM/yyyy"

#define DATE_FORMAT_FULL            @"dd MMM yyyy - hh:mm:ss a"

#define iOS_8                       ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define FORMAT_DATE_SERVER          DATE_FORMAT_LONG_SERVER


//define for Progindicator
#define GET_INDICATOR               (HTProgressHUD *)objc_getAssociatedObject(self, (__bridge const void *)([self class]))

#define INIT_INDICATOR              objc_setAssociatedObject(self, (__bridge const void *)([self class]), [[HTProgressHUD alloc] init], OBJC_ASSOCIATION_RETAIN_NONATOMIC)

#define SHOW_INDICATOR(sview)       [GET_INDICATOR showInView:sview animated:YES]

#define HIDE_INDICATOR(animated)    [GET_INDICATOR hideWithAnimation:animated]

#define TINT_DEF_COLR               @"f3731c"

#define TINT_COLOR                 [UserDefault user].tintColor ? [UserDefault user].tintColor : TINT_DEF_COLR

#define STREAM_URL                  @"http://ic2.christiannetcast.com/wqme-fm"

