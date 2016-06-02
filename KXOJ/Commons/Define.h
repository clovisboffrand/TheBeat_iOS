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

#define CLASS_VC NSStringFromClass([self class])

#define kGoogle_Tracking_ID         @"UA-42428688-13"

#define GET_INDICATOR               (HTProgressHUD *)objc_getAssociatedObject(self, (__bridge const void *)([self class]))

#define INIT_INDICATOR              objc_setAssociatedObject(self, (__bridge const void *)([self class]), [[HTProgressHUD alloc] init], OBJC_ASSOCIATION_RETAIN_NONATOMIC)

#define SHOW_INDICATOR(sview)       [GET_INDICATOR showInView:sview animated:YES]

#define HIDE_INDICATOR(animated)    [GET_INDICATOR hideWithAnimation:animated]

#define TINT_DEF_COLR               @"13016c"

#define STREAM_URL                  @"http://ic2.christiannetcast.com/wqme-fm"

