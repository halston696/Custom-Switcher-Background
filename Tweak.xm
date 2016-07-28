// Custom Switcher Background © 2016 Wylliam Altman (@halston696)

#import <libcolorpicker.h>

static NSString *const CSBSettings = @"/var/mobile/Library/Preferences/com.halston696.customswitcherbackground.plist";
static NSMutableDictionary *settings;

void refreshPrefs(){
    if(kCFCoreFoundationVersionNumber > 900.00){
	[settings release];
	CFStringRef appID = CFSTR("com.halston696.customswitcherbackground");
	CFArrayRef keyList = CFPreferencesCopyKeyList(appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if(keyList){
	    settings = (NSMutableDictionary *)CFPreferencesCopyMultiple(keyList, appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	    CFRelease(keyList);
	}
	else{
	    settings = nil;
	}
    }
    else{
	[settings release];
	settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[CSBSettings stringByExpandingTildeInPath]];
    }
}

static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
    refreshPrefs();
}

%group main
%hook SBAppSwitcherSettings
-(double)deckSwitcherBackgroundDarkeningFactor{
    if(settings != nil && ([settings count] != 0) && [[settings objectForKey:@"enabled"] boolValue] == YES && [[settings objectForKey:@"hideOverlay"] boolValue] == YES){
	return 0;
    }
    else {
	return %orig;
    }
}
-(double)deckSwitcherForegroundDarkeningFactor{
    if(settings != nil && ([settings count] != 0) && [[settings objectForKey:@"enabled"] boolValue] == YES && [[settings objectForKey:@"hideOverlay"] boolValue] == YES){
	return 0;
    }
    else {
	return %orig;
    }
}
%end

%hook SBSwitcherContainerView
-(void)layoutSubviews{
    %orig;
    if(settings != nil && ([settings count] != 0) && [[settings objectForKey:@"enabled"] boolValue] == YES){
	[self setBackgroundColor:LCPParseColorString([settings objectForKey:@"aColor"], @"#000000")];
    }
}
%end
%end

%ctor {
    @autoreleasepool {
	settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[CSBSettings stringByExpandingTildeInPath]];
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.halston696.customswitcherbackground/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	refreshPrefs();
	%init(main);
    }
}