//
//  DTAGeoFencing.m
//  DowntownAllianceHistory
//
//  Created by flatiron on 8/5/14.
//
//

#import "DTAGeoFencing.h"
@interface DTAGeoFencing ()

@end

@implementation DTAGeoFencing

-(void)setUpGeoFences
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    [self setUpRegions];
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }

    [self.locationManager stopUpdatingLocation];
}

- (void)setUpRegions
{
    
    if (self.setOfLocationsForGeofencing == nil) {
        [self createLocationsForGeoFencing];
    }
    
    if (self.setOfRegions == nil) {
        self.setOfRegions = [[NSMutableArray alloc] init];
        NSInteger locationNumber = 0;
        
        for (CLLocation *location in self.setOfLocationsForGeofencing) {
            CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:location.coordinate radius:100 identifier:[NSString stringWithFormat:@"Identifier%d", locationNumber]];
            [self.setOfRegions addObject:region];
            
            CLLocationDegrees regionCenterLatitude = region.center.latitude;
            CLLocationDegrees regionCenterLongitude = region.center.longitude;
            
            CLLocation *centerOfRegion = [[CLLocation alloc] initWithLatitude:regionCenterLatitude longitude:regionCenterLongitude];
            
            CLLocationDistance distanceFromRegion = [self.locationManager.location distanceFromLocation:centerOfRegion];

            if (distanceFromRegion > 150) {
//                [self respondToUserPresenceInRegion];
            }
            
            locationNumber++;
        }
    }
    
    for (CLCircularRegion *region in self.setOfRegions) {
        [self.locationManager startMonitoringForRegion:region];
    }
    
    NSLog(@"Monitored regions %@", self.locationManager.monitoredRegions);
}



- (void)createLocationsForGeoFencing
{
    NSArray *coordinates = @[@[@40.704687, @-74.014128],
                             @[@40.705736, @-74.013367],
                             @[@40.706737, @-74.012519],
                             @[@40.707477, @-74.011875],
                             @[@40.708615, @-74.011081],
                             @[@40.708493, @-74.011156],
                             @[@40.709266, @-74.010502],
                             @[@40.711022, @-74.009021],
                             @[@40.711811, @-74.008286]];
    
    self.setOfLocationsForGeofencing = [[NSMutableArray alloc] init];
    
    for (NSArray *coordinateSet in coordinates) {
        double latitude = [coordinateSet[0] doubleValue];
        double longitude = [coordinateSet[1] doubleValue];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];

        [self.setOfLocationsForGeofencing addObject:location];
    }
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Entered region: %@", region);
    
    if ([self isValidTimeForAlerts]) {
        [self respondToUserPresenceInRegion];
    }
}

- (BOOL)isValidTimeForAlerts
{
    NSInteger priorNumberOfAlerts = [self getPriorNumberOfAlertsSeen];
    
    if (priorNumberOfAlerts == 0 || (priorNumberOfAlerts < 3 && [self hasAppropriateTimePassedSincePriorAlert])){
        return YES;
    } else {
        return NO;
    }
}

- (void)respondToUserPresenceInRegion
{
    [self showAlert];
    [self adjustUserDefaultsToLimitNumberOfLocationAlertsShown];
}

- (void)showAlert
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Welcome!"
                                                      message:@"You are now near the Canyon of Heroes!"
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
}

- (NSInteger)getPriorNumberOfAlertsSeen
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger numberOfAlertsSeen = [defaults integerForKey:@"alertsShown"];
    
    return numberOfAlertsSeen;
}

- (void)adjustUserDefaultsToLimitNumberOfLocationAlertsShown
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *alertsKey = @"alertsShown";
    NSInteger alertsPreviouslyShown = [defaults integerForKey:alertsKey];
    
    if (alertsPreviouslyShown == 0) {
        [defaults setInteger:1 forKey:alertsKey];
    } else if (alertsPreviouslyShown == 1) {
        [defaults setInteger:2 forKey:alertsKey];
    } else {
        [defaults setInteger:3 forKey:alertsKey];
    }
    
    [self registerTimeAndDateOfAlert];
}

- (BOOL)hasAppropriateTimePassedSincePriorAlert
{
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    NSDate *dateOfLastAlert = [defaults valueForKey:@"dateAndTimeOfLastAlert"];
    
    if (dateOfLastAlert > 0 && [[NSDate date] timeIntervalSinceDate:dateOfLastAlert] > 15) {
        return YES;
    } else {
        return NO;
    }
}

- (void)registerTimeAndDateOfAlert
{
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    NSDate *now = [NSDate date];

    [defaults setObject:now forKey:@"dateAndTimeOfLastAlert"];
}

- (NSDate *)getTimeAndDateOfLastAlert
{
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    NSDate *lastAlertDate = [defaults valueForKey:@"dateAndTimeOfLastAlert"];
    
    return lastAlertDate;
}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
//    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
//    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60];
//    localNotification.alertBody = @"Your alert message";
//    localNotification.timeZone = [NSTimeZone defaultTimeZone];
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//    
//    // Override point for customization after application launch.
//    
//    // Handle launching from a notification
//    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//    if (locationNotification) {
//        // Set icon badge number to zero
//        application.applicationIconBadgeNumber = 0;
//    }
//    
//    return YES;
//}

//-(EKStructuredLocation*)createStructuredLocation
//{
//    EKStructuredLocation *structuredLocation = [EKStructuredLocation locationWithTitle:@"structuredLocation"];
//    CLCircularRegion *myRegion = [self.locationManager.monitoredRegions allObjects][0];
//    CLLocation *locationForStructLoc = [[CLLocation alloc] initWithLatitude:myRegion.center.latitude longitude:myRegion.center.longitude];
//    structuredLocation.geoLocation = locationForStructLoc;
//    structuredLocation.radius = myRegion.radius;
//    return structuredLocation;
//}
//
//-(EKAlarm*)createAlarm
//{
//    EKAlarm *alarm = [[EKAlarm alloc]init];
//    alarm.proximity = EKAlarmProximityEnter;
//    alarm.structuredLocation = [self createStructuredLocation];
//    return alarm;
//    
//}
//
//-(void)setupAlarmWithEventStore:(EKEventStore*)eventStore AndLocationManager:(CLLocationManager *)locationManager
//{
//    
//    EKReminder *reminder = [EKReminder reminderWithEventStore:eventStore];
//    NSString *titleString = [NSString stringWithFormat:@"Rxxx You have arrived at\n%@",locationManager.monitoredRegions.allObjects[0]];
//    reminder.title = titleString;
//    reminder.calendar = [eventStore defaultCalendarForNewReminders];
//    EKAlarm *fenceAlarm = [self createAlarm];
//    [reminder addAlarm:fenceAlarm];
//    NSError *error = nil;
//    [eventStore saveReminder:reminder commit:YES error:&error];
//}

@end
