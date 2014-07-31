//
//  DTAAppDelegate.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "DTAAppDelegate.h"
#import "DTADataFetchFromCSV.h"
#import "Location.h"
#import "DTACategoriesTableViewController.h"
#import "DTAManageTimeRanges.h"

@implementation DTAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Decades input dictionary takes a start date string and label for the time period
    
    NSDictionary *datesDictionary = @{@"01-01-1899":@"pre-1920s",
                                      @"01-01-1920":@"1920s",
                                      @"01-01-1930":@"1930s",
                                      @"01-01-1940":@"1940s",
                                      @"01-01-1950":@"1950s",
                                      @"01-01-1960":@"1960s",
                                      @"01-01-1970":@"1970s",
                                      @"01-01-1980":@"1980s",
                                      @"01-01-1990":@"1990s",
                                      @"01-01-2000":@"2000s"};
    
    [DTAManageTimeRanges generateDefaultTimeIntervalsFromArrayOfDates:datesDictionary];
    
    return YES;
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
