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

- (void)setLocationDecade:(Decade *)decade Theme:(Theme *)theme
{
    self.decade = decade;
    self.theme = theme;
}

@end
