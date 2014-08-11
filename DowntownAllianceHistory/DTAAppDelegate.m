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
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
