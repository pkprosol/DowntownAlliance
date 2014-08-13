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

@interface DTAMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (strong, nonatomic) Location *location;
- (id)initWithLocation:(CLLocationCoordinate2D)coord;


@end
