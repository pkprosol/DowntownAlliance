//
//  DTAGeoFencing.h
//  DowntownAllianceHistory
//
//  Created by flatiron on 8/5/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface DTAUserLocationManagement : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *setOfLocationsForGeofencing;
@property (nonatomic, strong) NSMutableArray *setOfRegions;
@property (nonatomic) NSInteger defaultDistanceInMeters;
@property (nonatomic) NSInteger attemptsToStartLocationTracking;

@property (nonatomic) NSInteger maxNumberOfAlertsToShow;
@property (nonatomic) NSInteger minIntervalBetweenLocationAlerts;
@property (strong, nonatomic) UIAlertView *standardLocationAlert;
@property (strong, nonatomic) UILocalNotification *standardBackgroundNotification;

- (void)setUpLocationManagementAndRegions;

@end
