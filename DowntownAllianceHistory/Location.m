//
//  Location.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "Location.h"


@implementation Location

- (instancetype)initWithComponentStringArray:(NSArray *)componentStringArray
{
    self = [super init];
    if (self) {
        self.idNumber = componentStringArray[0];
        self.latitude = [componentStringArray[2] floatValue];
        self.longitude = [componentStringArray[3] floatValue];
    }
    
    return self;
}

@end
