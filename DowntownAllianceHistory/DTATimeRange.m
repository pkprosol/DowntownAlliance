//
//  DTATimeRange.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/31/14.
//
//

#import "DTATimeRange.h"

@implementation DTATimeRange

- (instancetype)initWithName:(NSString *)nameOfRange BeginningDate:(NSDate *)beginningDate EndDate:(NSDate *)endDate;
{
    self = [super init];
    if (self) {
        _nameOfRange = nameOfRange;
        _beginningDate = beginningDate;
        _endDate = endDate;
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithName:@"" BeginningDate:nil EndDate:nil];
}

@end
