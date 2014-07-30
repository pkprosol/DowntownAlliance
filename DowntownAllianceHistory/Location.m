//
//  Location.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/30/14.
//
//

#import "Location.h"
#import "Decade.h"
#import "Theme.h"


@implementation Location

@dynamic name;
@dynamic idNumber;
@dynamic symbolValue;
@dynamic latitude;
@dynamic longitude;
@dynamic month;
@dynamic day;
@dynamic year;
@dynamic details;
@dynamic theme;
@dynamic decade;

- (void)setUpLocationDataWithComponentArray:(NSArray *)componentArray
{
    self.idNumber = componentArray[0];
    self.latitude = componentArray[2];
    self.longitude = componentArray[3];
}

@end
