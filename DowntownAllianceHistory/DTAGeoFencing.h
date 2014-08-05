//
//  DTAGeoFencing.h
//  DowntownAllianceHistory
//
//  Created by flatiron on 8/5/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface DTAGeoFencing : NSObject <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *geofences;

-(void)getGeofence;

@end
