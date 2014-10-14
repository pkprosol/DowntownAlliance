//
//  DTAAppDelegate.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "DTAAppDelegate.h"
#import "DTAUserLocationManagement.h"
#import "DTASetUpDefaultData.h"
#import "DTAAppLinkViewController.h"

@implementation DTAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setUpFromGeoFence];
    [self setUpDefaultBars];
    
    [DTASetUpDefaultData setUpDefaultData];
    
    return YES;
}

- (void)setUpDefaultBars {
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setTranslucent:NO];
    
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

- (void)setUpFromGeoFence
{
    self.geoFence = [[DTAUserLocationManagement alloc] init];
    
    [self.geoFence setUpLocationManagementAndRegions];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
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
