//
//  DTATimeRange.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/31/14.
//
//

#import "DTATimeRange.h"

@implementation DTATimeRange

- (instancetype)initWithName:(NSString *)nameOfRange BeginningDate:(NSDate *)beginningDate EndDate:(NSDate *)endDate Image:(UIImage *)imageForRange
{
    self = [super init];
    if (self) {
        self.nameOfRange = nameOfRange;
        self.beginningDate = beginningDate;
        self.endDate = endDate;
        self.imageForRange = imageForRange;
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithName:@"" BeginningDate:nil EndDate:nil Image:nil];
}

@end
