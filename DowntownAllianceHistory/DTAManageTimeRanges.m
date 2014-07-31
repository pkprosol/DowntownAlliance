//
//  DTAManageTimeRanges.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/31/14.
//
//

#import "DTAManageTimeRanges.h"

@implementation DTAManageTimeRanges

+ (DTATimeRange *)generateTimeRangeWithName:(NSString *)name StartDate:(NSDate *)startDate AndEndDate:(NSDate *)endDate;
{
    DTATimeRange *newTimeRange = [[DTATimeRange alloc] initWithName:name BeginningDate:startDate EndDate:endDate];
    
    return newTimeRange;
}

+ (NSArray *)generateDefaultTimeIntervalsFromArrayOfDates:(NSArray *)dates
{
    NSMutableArray *resultingTimeIntervals = [NSMutableArray new];
    
    // Decades input dictionary takes label for time period and start date string
    NSDictionary *decadesInputDictionary = @{@"pre-1920s":@"01-01-1899",
                                             @"1920s":@"01-01-1920",
                                             @"1930s":@"01-01-1930",
                                             @"1940s":@"01-01-1940",
                                             @"1950s":@"01-01-1950",
                                             @"1960s":@"01-01-1960",
                                             @"1970s":@"01-01-1970",
                                             @"1980s":@"01-01-1980",
                                             @"1990s":@"01-01-1990",
                                             @"2000s":@"01-01-2000"};
    
    for (NSInteger i=0; i < ([dates count] - 1); i++) {
       // DTATimeRange *newRange = [DTAManageTimeRanges generateTimeRangeWithName:<#(NSString *)#> StartDate:<#(NSDate *)#> AndEndDate:<#(NSDate *)#>
    }
    
    return resultingTimeIntervals;
}

@end
