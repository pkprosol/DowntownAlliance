//
//  DTAGeoFencing.m
//  DowntownAllianceHistory
//
//  Created by flatiron on 8/5/14.
//
//

#import "DTAGeoFencing.h"
@interface DTAGeoFencing ()
{
    BOOL _didStartMonitoringRegion;
}
@end
@implementation DTAGeoFencing


-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    // _didStartMonitoringRegion = YES;
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Hello World!"
                                                      message:@"You are now near the canyon of heroes!"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLCircularRegion *)region
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Goodbye World!"
                                                      message:@"You are now leaving the canyon of heroes!"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

-(EKStructuredLocation*)createStructuredLocation
{
    EKStructuredLocation *structuredLocation = [EKStructuredLocation locationWithTitle:@"structuredLocation"];
    CLCircularRegion *myRegion = [self.locationManager.monitoredRegions allObjects][0];
    CLLocation *locationForStructLoc = [[CLLocation alloc] initWithLatitude:myRegion.center.latitude longitude:myRegion.center.longitude];
    structuredLocation.geoLocation = locationForStructLoc;
    structuredLocation.radius = myRegion.radius;
    return structuredLocation;
}

-(EKAlarm*)createAlarm
{
    EKAlarm *alarm = [[EKAlarm alloc]init];
    alarm.proximity = EKAlarmProximityEnter;
    alarm.structuredLocation = [self createStructuredLocation];
    return alarm;
}

-(void)setupAlarmWithEventStore:(EKEventStore*)eventStore AndLocationManager:(CLLocationManager *)locationManager
{
    
    EKReminder *reminder = [EKReminder reminderWithEventStore:eventStore];
    NSString *titleString = [NSString stringWithFormat:@"Rxxx You have arrived at\n%@",locationManager.monitoredRegions.allObjects[0]];
    reminder.title = titleString;
    reminder.calendar = [eventStore defaultCalendarForNewReminders];
    EKAlarm *fenceAlarm = [self createAlarm];
    [reminder addAlarm:fenceAlarm];
    NSError *error = nil;
    [eventStore saveReminder:reminder commit:YES error:&error];
}

-(void)getGeofence
{
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:40.709509 longitude:-74.01025];
    
    // Initialize Region to Monitor
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:location.coordinate radius:25 identifier:@"Identifier"];
    NSSet *regions = self.locationManager.monitoredRegions;
    self.locationManager.delegate = self;
    
    // Start Monitoring Region
    [self.locationManager startMonitoringForRegion:region];
    [self.locationManager startUpdatingLocation];
    [self.locationManager stopUpdatingLocation];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

UILocalNotification* localNotification = [[UILocalNotification alloc] init];
localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60];
localNotification.alertBody = @"Your alert message";
localNotification.timeZone = [NSTimeZone defaultTimeZone];
[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

    // Override point for customization after application launch.
    
    // Handle launching from a notification
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (locationNotification) {
        // Set icon badge number to zero
        application.applicationIconBadgeNumber = 0;
    }
    
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"%@",error);
}

@end
