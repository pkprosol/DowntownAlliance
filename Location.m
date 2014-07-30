//
//  Location.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "Location.h"
#import "Decade.h"
#import "Theme.h"


@implementation Location

@dynamic details;
@dynamic idNumber;
@dynamic latitude;
@dynamic longitude;
@dynamic name;
@dynamic symbolValue;
@dynamic decade;
@dynamic theme;

- (void)setUpLocationDataWithComponentArray:(NSArray *)componentArray
{
    self.idNumber = componentArray[0];
    self.latitude = componentArray[2];
    self.longitude = componentArray[3];
}

@end
