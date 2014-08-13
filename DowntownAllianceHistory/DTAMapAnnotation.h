//
//  DTAMapAnnotation.h
//  DowntownAllianceHistory
//
//  Created by Viktor Falkner on 8/12/14.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Location.h"

@interface DTAMapAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coorinate;
}

@property (strong, nonatomic) Location *location;
- (id)initWithLocation:(CLLocationCoordinate2D)coord;


@end
