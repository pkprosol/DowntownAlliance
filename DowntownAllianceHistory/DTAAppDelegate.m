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
//         UIColor *downtownAllianceRed =[UIColor colorWithRed:(237/255.0) green:(26/255.0) blue:(44/255.0) alpha:1];
    
    // Add this if you only want to change Selected Image color
    // and/or selected image text
//    [[UITabBar appearance] setTintColor:downtownAllianceRed];
//    
////    [[UINavigationBar appearance] setBarTintColor:downtownAllianceRed];
//    
//    // Add this code to change StateNormal text Color,
//    
//    [UITabBarItem.appearance setTitleTextAttributes:
//     @{NSForegroundColorAttributeName : [UIColor whiteColor]}
//                                           forState:UIControlStateNormal];
//    
//    // then if StateSelected should be different, you should add this code
//    [UITabBarItem.appearance setTitleTextAttributes:
//     @{NSForegroundColorAttributeName : [UIColor whiteColor]}
//                                           forState:UIControlStateSelected];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    [self setUpFromGeoFence];

   

    
    [DTASetUpDefaultData setUpDefaultData];
    
    return YES;
}
  -(void)setUpFromGeoFence
{

   self.geoFence = [[DTAGeoFencing alloc]init];
    
    // Initialize Location Manager
    self.geoFence.locationManager = [[CLLocationManager alloc] init];
    
    // Configure Location Manager
   // [self.geoFence.locationManager setDelegate:self.geoFence];
    [self.geoFence.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    // Load Geofences
//    self.geoFence.geofences = [NSMutableArray arrayWithArray:[[self.geoFence.locationManager monitoredRegions] allObjects]];
    
    [self.geoFence getGeofence];
   // [self.geoFence.locationManager startUpdatingLocation];
    
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
