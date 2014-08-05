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

-(void)getGeofence
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:40.709509 longitude:74.010258];
    
    // Initialize Region to Monitor
    CLCircularRegion *region = [[CLCircularRegion alloc] initCircularRegionWithCenter:[location coordinate] radius:1000.0 identifier:[[NSUUID UUID] UUIDString]];
    
    
    
    // Start Monitoring Region
    [self.locationManager startMonitoringForRegion:region];
    [self.locationManager stopUpdatingLocation];
    NSLog(@"in the area %f %f", region.center.latitude, region.center.longitude);
    
}

-(void)awakeFromNib
    {
    
    }

//-(void)addCurrentLocation:(id)sender
//    {
//        // Update Helper
//        _didStartMonitoringRegion = NO;
//        
//        // Start Updating Location
//        [self.locationManager startUpdatingLocation];
//    }

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (locations && [locations count] && !_didStartMonitoringRegion) {
        // Update Helper
        _didStartMonitoringRegion = YES;
        
        // Fetch Current Location
        CLLocation *location = [locations objectAtIndex:0];
        
        CLLocation *location2 = [[CLLocation alloc] initWithLatitude:40.709509 longitude:74.010258];
        
        // Initialize Region to Monitor
        CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:[location2 coordinate] radius:250.0 identifier:[[NSUUID UUID] UUIDString]];
        
        
        
        // Start Monitoring Region
        [self.locationManager startMonitoringForRegion:region];
        [self.locationManager stopUpdatingLocation];
        
        //        // Update Table View
        //        [self.geofences addObject:region];
        //        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:([self.geofences count] - 1) inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        // self.locationManager = locations.lastObject;
        
        // Update View
        //  [self updateView];
    }
}
    
    

@end
