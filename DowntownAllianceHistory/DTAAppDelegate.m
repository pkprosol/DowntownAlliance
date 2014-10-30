//
//  DTAAppDelegate.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "DTAAppDelegate.h"
#import "DTASetUpDefaultData.h"
#import "DTADataStore.h"
#import "DTAUserLocationManagement.h"
#import "DTAAppLinkViewController.h"
#import "DTAMapViewController.h"

@implementation DTAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setUpDefaultBars];
    [self setUpFromGeoFence];
    
    DTADataStore *dataStore = [DTADataStore sharedDataStore];

    if (!dataStore.defaultTimeIntervalsArray || !dataStore.defaultThemesArray) {
        [DTASetUpDefaultData setUpDefaultData];
    }
    
    return YES;
}

- (void)setUpDefaultBars {
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

- (void)setUpFromGeoFence {
    self.userLocationManagement = [[DTAUserLocationManagement alloc] init];
    [self.userLocationManagement setUpLocationManagementAndRegions];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self respondToReturnFromDTAApp];
}

- (void)respondToReturnFromDTAApp
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL didGoToDowntownAllianceApp = [defaults boolForKey:@"wentToDowntownAllianceApp"];
    
    if (didGoToDowntownAllianceApp) {
        [defaults setBool:NO forKey:@"wentToDowntownAllianceApp"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *homeViewController = [storyboard instantiateInitialViewController];
        
        self.window.rootViewController = homeViewController;
        [self.window makeKeyAndVisible];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = application.applicationIconBadgeNumber - 1;

}

@end
