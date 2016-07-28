#include "csbRootListController.h"
#import <Social/Social.h>

#define devTwitterURL @"https://twitter.com/halston696"

@implementation csbRootListController
- (NSArray *)specifiers {
    if (!_specifiers) {
    _specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
    }
    return _specifiers;
}

- (void)viewWillAppear:(BOOL)animated{
    [self reload];
    [super viewWillAppear:animated];
}

- (id)init {
    if (self == [super init]) {
	UIButton *tweet = [[[UIButton alloc] initWithFrame:CGRectZero] autorelease];
	[tweet setImage:[[UIImage alloc] initWithContentsOfFile:[[NSBundle bundleWithPath:@"/Library/PreferenceBundles/CSB.bundle"] pathForResource:@"tweet" ofType:@"png"]] forState:UIControlStateNormal];
	[tweet sizeToFit];
	[tweet addTarget:self action:@selector(shareViaTwitter) forControlEvents:UIControlEventTouchUpInside];
	self.navigationItem.rightBarButtonItem =  [[[UIBarButtonItem alloc] initWithCustomView:tweet] autorelease];
    }
    return self;
}

- (void)shareViaTwitter{
    SLComposeViewController *twitter = [[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter] retain];
    [twitter setInitialText:@"i'm using #CustomSwitcherBackground by @halston696"];
    if (twitter != nil)
	[[self navigationController] presentViewController:twitter animated:YES completion:nil];
    [twitter release];
}

- (void)devTwitter:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:devTwitterURL]];
}

- (void)respring:(id)sender {
    system("killall SpringBoard");
}
@end
