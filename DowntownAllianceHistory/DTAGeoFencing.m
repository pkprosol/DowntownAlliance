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
    self.locationManager.distanceFilter = 50.0f;
    
    [self setUpRegions];
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }
}

- (void)setUpRegions
{
    
    if (self.setOfLocationsForGeofencing == nil) {
        [self createLocationsForGeoFencing];
    }
    
    if (self.setOfRegions == nil) {
        self.setOfRegions = [[NSMutableArray alloc] init];
        NSInteger locationNumber = 0;
        self.defaultDistanceInMeters = 200;
        
        for (CLLocation *location in self.setOfLocationsForGeofencing) {
            CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:location.coordinate radius:self.defaultDistanceInMeters identifier:[NSString stringWithFormat:@"Identifier%ld", (long)locationNumber]];
            [self.setOfRegions addObject:region];
            
            locationNumber++;
        }
    }
    
    for (CLCircularRegion *region in self.setOfRegions) {
        [self.locationManager startMonitoringForRegion:region];
    }
    
    [self performSelector:@selector(checkAndRespondIfUserIsAlreadyInRegion) withObject:nil afterDelay:8];
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

- (void)checkAndRespondIfUserIsAlreadyInRegion
{
    for (CLRegion *region in self.setOfRegions) {
        CLLocationDegrees regionCenterLatitude = region.center.latitude;
        CLLocationDegrees regionCenterLongitude = region.center.longitude;
        
        CLLocation *centerOfRegion = [[CLLocation alloc] initWithLatitude:regionCenterLatitude longitude:regionCenterLongitude];
        
        CLLocationDistance distanceFromRegion = [self.locationManager.location distanceFromLocation:centerOfRegion];
        
        if (self.locationManager.location != nil && distanceFromRegion < self.defaultDistanceInMeters && [self isValidTimeForAlerts]) {
            [self adjustUserDefaultsToLimitNumberOfLocationAlertsShown];
            [self performSelector:@selector(showUserProximityAlert) withObject:nil afterDelay:2];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Entered region: %@", region);
    
    if ([self isValidTimeForAlerts]) {
        [self adjustUserDefaultsToLimitNumberOfLocationAlertsShown];
        [self showUserProximityAlert];
    }
}

- (BOOL)isValidTimeForAlerts
{
    NSInteger priorNumberOfAlerts = [self getPriorNumberOfAlertsSeen];
    
    if (priorNumberOfAlerts == 0 || (priorNumberOfAlerts > 0 && priorNumberOfAlerts < 3 && [self hasAppropriateTimePassedSincePriorAlert])){
        return YES;
    } else {
        return NO;
    }
}

- (void)showUserProximityAlert
{
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    
    if (state == UIApplicationStateBackground || state == UIApplicationStateInactive)
    {
        [self fireBackgroundNotification];
    } else {
        UIAlertView *userEnteredRegion = [[UIAlertView alloc]initWithTitle:@"Welcome!"
                                                                   message:@"You are near the Canyon of Heroes!"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
        
        [userEnteredRegion show];
    }
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
    
    NSInteger secondsInOneWeek = 604800;
    
    if (dateOfLastAlert > 0 && [[NSDate date] timeIntervalSinceDate:dateOfLastAlert] > secondsInOneWeek) {
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

- (void)fireBackgroundNotification
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate date];
    localNotification.alertBody = @"You are near the Canyon of Heroes!";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}



@end
