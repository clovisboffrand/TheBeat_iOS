//
//  UITypedefDefinition.h
//  Roots
//
//  Created by Harry Tran on 11/27/14.
//  Copyright (c) 2014 HarryTran. All rights reserved.
//

#ifndef Roots_UITypedefDefinition_h
#define Roots_UITypedefDefinition_h

typedef NS_OPTIONS(NSInteger, kEditorOptionType) {
    kEditorOptionTypeText = 1,
    kEditorOptionTypeRotate ,
    kEditorOptionTypeVoice ,
    kEditorOptionTypeTrim ,
    kEditorOptionTypeSound ,
    kEditorOptionTypeCopy ,
    kEditorOptionTypeSettings,
    kEditorOptionTypeDelete
};

typedef NS_OPTIONS(NSInteger, kLibraryAudioOption) {
    kLibraryAudioOptionIphone = 0,
    kLibraryAudioOptionLocal = 1,
};

typedef NS_OPTIONS(NSInteger, kViewControllerMode) {
    kViewControllerModeView = 0,
    kViewControllerModeEdit = 1,
    kViewControllerModeAdd  = 2,
};

typedef NS_OPTIONS(NSInteger, kSettingsOptions) {
    kSOOption           = 0,
    kSOSetTimeTracking  = 1,
    kSOExportData       = 2,
    kSOSaveBattery      = 3,
    kSOMapSettings      = 4,
    kSOTermsOfUse       = 5,
    kSOLogout           = 6,

};

#endif
