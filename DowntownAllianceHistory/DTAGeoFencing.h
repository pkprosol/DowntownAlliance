//
//  DTAGeoFencing.h
//  DowntownAllianceHistory
//
//  Created by flatiron on 8/5/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <EventKit/EventKit.h>

@interface DTAGeoFencing : NSObject <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *geofences;
@property (strong, nonatomic) DTAGeoFencing *geoFence;
@property (strong, nonatomic) CLLocation *locations;
// EKEventStore instance associated with the current Calendar application
@property (nonatomic, strong) EKEventStore *eventStore;
// Default calendar associated with the above event store
@property (nonatomic, strong) EKCalendar *defaultCalendar;
// Array of all events happening within the next 24 hours
@property (nonatomic, strong) NSMutableArray *eventsList;


-(void)getGeofence;
-(CLCircularRegion*)createFence;
-(EKAlarm*)createAlarm;
@end
