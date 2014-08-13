//
//  DTAMapAnnotation.m
//  DowntownAllianceHistory
//
//  Created by Viktor Falkner on 8/12/14.
//
//

#import "DTAMapAnnotation.h"

@implementation DTAMapAnnotation

@synthesize coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self){
        self.coordinate = coord;
    }
    return  self;
}


@end
