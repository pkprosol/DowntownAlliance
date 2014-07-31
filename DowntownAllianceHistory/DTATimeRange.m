//
//  DTATimeRange.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/31/14.
//
//

#import "DTATimeRange.h"

@implementation DTATimeRange

- (instancetype)initWithName:(NSString *)nameOfRange BeginningTime:(NSInteger)beginningTime LengthOfTime:(NSInteger)lengthOfTime
{
    self = [super init];
    if (self) {
        _nameOfRange = nameOfRange;
        _beginningTime = beginningTime;
        _lengthOfTime = lengthOfTime;
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithName:@"" BeginningTime:0 LengthOfTime:0];
}

@end
