//
//  DTAAppDelegate.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "DTAAppDelegate.h"
#import "DTAGeoFencing.h"
#import "DTASetUpDefaultData.h"
#import "DTAAppLinkViewController.h"


@implementation DTAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];

    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              [UIColor whiteColor],
                                                          NSForegroundColorAttributeName, nil]];

    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    
    [self setUpFromGeoFence];
   
    [DTASetUpDefaultData setUpDefaultData];
    
    return YES;
}

- (void)setUpFromGeoFence
{
    self.geoFence = [[DTAGeoFencing alloc]init];
    
    [self.geoFence setUpGeoFences];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
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

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=application.applicationIconBadgeNumber-1;
}

@end
