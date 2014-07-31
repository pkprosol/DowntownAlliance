//
//  DTAManageTimeRanges.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/31/14.
//
//

#import "DTAManageTimeRanges.h"

@implementation DTAManageTimeRanges

+ (DTATimeRange *)generateTimeRangeWithName:(NSString *)name StartDate:(NSDate *)startDate EndDate:(NSDate *)endDate Image:(UIImage *)image;
{
    DTATimeRange *newTimeRange = [[DTATimeRange alloc] initWithName:name BeginningDate:startDate EndDate:endDate Image:image];
    
    return newTimeRange;
}

+ (NSArray *)generateDefaultTimeIntervalsFromDictionaryOfDates:(NSDictionary *)intervalsSetting ArrayOfImages:(NSArray *)imagesArray
{
    NSMutableArray *resultingTimeIntervals = [NSMutableArray new];
    
    
    NSArray *startingDatesKeys = [[intervalsSetting allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"MM-dd-yyyy"];
    
    for (NSInteger i=0; i < ([startingDatesKeys count]); i++) {
        NSString *currentKey = startingDatesKeys[i];
        NSString *nextKey = [NSString new];
        
        if (i == [startingDatesKeys count] - 1) {
            nextKey = @"01-01-2161";
        } else {
            nextKey = startingDatesKeys[i+1];
        }
        
        NSString *nameOfInterval = intervalsSetting[currentKey];
        NSString *startDateString = currentKey;
        NSString *endDateString = nextKey;
        UIImage *imageForTimeRange = imagesArray[i];
        
        // Need to reduce endDate by one so intervals don't overlap
        
        NSDate *startDate = [dateFormat dateFromString:startDateString];
        
        NSDate *endDateUnadjusted = [dateFormat dateFromString:endDateString];
        NSDate *endDate = [endDateUnadjusted dateByAddingTimeInterval:-43200]; // Half a day
        
        DTATimeRange *newRange = [DTAManageTimeRanges generateTimeRangeWithName:nameOfInterval StartDate:startDate EndDate:endDate Image:imageForTimeRange];
        
        [resultingTimeIntervals addObject:newRange];
    }
    
    for (DTATimeRange *timeRange in resultingTimeIntervals) {
        NSLog(@"Name: %@, Start date: %@, End date: %@", timeRange.nameOfRange, timeRange.beginningDate, timeRange.endDate);
    }
    
    return resultingTimeIntervals;
}

@end
