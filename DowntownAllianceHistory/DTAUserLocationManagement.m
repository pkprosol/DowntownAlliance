//
//  DTAGeoFencing.m
//  DowntownAllianceHistory
//
//  Created by flatiron on 8/5/14.
//
//

#import "DTAUserLocationManagement.h"

@interface DTAUserLocationManagement ()

@end

@implementation DTAUserLocationManagement

-(void)setUpLocationManagementAndRegions {
    [self setUpLocationTracking];
    [self setUpRegions];
    [self setUpLocationAlerts];
}

- (void)setUpLocationTracking {
    if ([CLLocationManager locationServicesEnabled]) {
        if (self.locationManager == nil) {
            self.locationManager = [[CLLocationManager alloc] init];
        }
        
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
        
        CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
        
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization];
        }
        
        if (authorizationStatus != kCLAuthorizationStatusDenied) {
            [self.locationManager startUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location manager error: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"Locations: %@", locations.lastObject);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self.locationManager startUpdatingLocation];
    [self performSelector:@selector(checkAndRespondIfUserIsAlreadyInRegion) withObject:nil afterDelay:4];
}

- (void)setUpRegions {
    
    if (self.setOfLocationsForGeofencing == nil) {
        [self createLocationsForGeoFencing];
    }
    
    if (self.setOfRegions == nil) {
        self.setOfRegions = [[NSMutableArray alloc] init];
        NSInteger locationNumber = 0;
        self.defaultDistanceInMeters = 300;
        
        for (CLLocation *location in self.setOfLocationsForGeofencing) {
            CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:location.coordinate radius:self.defaultDistanceInMeters identifier:[NSString stringWithFormat:@"Identifier%ld", (long)locationNumber]];
            region.notifyOnEntry = YES;
            [self.setOfRegions addObject:region];
            
            locationNumber++;
        }
    }
    
    for (CLCircularRegion *region in self.setOfRegions) {
        [self.locationManager startMonitoringForRegion:region];
    }
    
    [self performSelector:@selector(checkAndRespondIfUserIsAlreadyInRegion) withObject:nil afterDelay:4];
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

- (void)setUpLocationAlerts {
    self.maxNumberOfAlertsToShow = 3;
    self.minIntervalBetweenLocationAlerts = 604800;
    
    self.standardLocationAlert = [[UIAlertView alloc]initWithTitle:@"Welcome!"
                                                           message:@"You are near the Canyon of Heroes! Check out the Main Map to see where you are."
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
    
    self.standardBackgroundNotification = [[UILocalNotification alloc] init];
    self.standardBackgroundNotification.fireDate = [NSDate date];
    self.standardBackgroundNotification.alertBody = @"You are near the Canyon of Heroes!";
    self.standardBackgroundNotification.soundName = UILocalNotificationDefaultSoundName;
}

- (void)checkAndRespondIfUserIsAlreadyInRegion
{
    for (CLCircularRegion *region in self.setOfRegions) {
        
        BOOL isUserInRegion = [region containsCoordinate:self.locationManager.location.coordinate];
        
        if (self.locationManager.location != nil && isUserInRegion && [self isValidTimeForAlerts]) {
                [self adjustUserDefaultsToLimitNumberOfLocationAlertsShown];
            [self performSelector:@selector(showUserProximityAlert) withObject:nil afterDelay:1];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{    
    if ([self isValidTimeForAlerts]) {
        [self adjustUserDefaultsToLimitNumberOfLocationAlertsShown];
        [self showUserProximityAlert];
    }
}

- (BOOL)isValidTimeForAlerts
{
    NSInteger priorNumberOfAlerts = [self getPriorNumberOfAlertsSeen];
    
    if (priorNumberOfAlerts == 0 || (priorNumberOfAlerts > 0 && priorNumberOfAlerts < self.maxNumberOfAlertsToShow && [self hasAppropriateTimePassedSincePriorAlert])){
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
        [self.standardLocationAlert show];
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
    
    if (alertsPreviouslyShown < self.maxNumberOfAlertsToShow) {
        alertsPreviouslyShown++;
        [defaults setInteger:alertsPreviouslyShown forKey:alertsKey];
    }
    
    [self registerTimeAndDateOfAlert];
}

- (BOOL)hasAppropriateTimePassedSincePriorAlert
{
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    NSDate *dateOfLastAlert = [defaults valueForKey:@"dateAndTimeOfLastAlert"];
    
    NSInteger intervalBetweenAlerts = self.minIntervalBetweenLocationAlerts;
    
    if (dateOfLastAlert > 0 && [[NSDate date] timeIntervalSinceDate:dateOfLastAlert] > intervalBetweenAlerts) {
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
    [[UIApplication sharedApplication] scheduleLocalNotification:self.standardBackgroundNotification];
}

@end
