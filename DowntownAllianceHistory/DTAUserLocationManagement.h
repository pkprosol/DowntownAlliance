//
//  DTAGeoFencing.h
//  DowntownAllianceHistory
//
//  Created by flatiron on 8/5/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface DTAUserLocationManagement : NSObject

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *setOfLocationsForGeofencing;
@property (nonatomic, strong) NSMutableArray *setOfRegions;
@property (nonatomic) NSInteger defaultDistanceInMeters;

- (void)setUpLocationManagementAndRegions;

@end
