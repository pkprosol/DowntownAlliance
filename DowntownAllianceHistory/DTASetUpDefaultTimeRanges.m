//
//  DTAManageTimeRanges.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/31/14.
//
//

#import "DTASetUpDefaultTimeRanges.h"
#import "DTAGenerateDefaultTimeRanges.h"
#import "DTADataStore.h"
#import "Location.h"
#import "DTADateFormatterAssistant.h"

@implementation DTASetUpDefaultTimeRanges

+ (DTATimeRange *)generateTimeRangeWithName:(NSString *)name StartDate:(NSDate *)startDate EndDate:(NSDate *)endDate Image:(UIImage *)image;
{
    DTATimeRange *newTimeRange = [[DTATimeRange alloc] initWithName:name BeginningDate:startDate EndDate:endDate Image:image];
    
    return newTimeRange;
}

+ (NSArray *)getAndProcessDefaultTimeRanges
{
    NSDictionary *intervalsSetting = [DTAGenerateDefaultTimeRanges generateDefaultDictionaryOfTimeIntervals];
    
    NSArray *imagesArray = [DTAGenerateDefaultTimeRanges generateDefaultArrayOfImagesToMatchTimeIntervals];
    
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
        
        NSDate *startDate = [dateFormat dateFromString:startDateString];
        
        NSDate *endDate = [dateFormat dateFromString:endDateString];
        
        DTATimeRange *newRange = [DTASetUpDefaultTimeRanges generateTimeRangeWithName:nameOfInterval StartDate:startDate EndDate:endDate Image:imageForTimeRange];
        
        [resultingTimeIntervals addObject:newRange];
    }
    
    return resultingTimeIntervals;
}

+ (NSArray *)findItemsInTimeRange:(DTATimeRange *)range
{
    DTADataStore *store = [DTADataStore sharedDataStore];
    NSArray *allItems = [store fetchDataForEntityName:@"Location"];
  
    NSMutableArray *itemsInRange = [NSMutableArray new];
    
    NSDate *beginningDate = range.beginningDate;
    NSDate *endDate = range.endDate;
    
    for (Location *currentLocation in allItems) {
        NSDate *year = [DTADateFormatterAssistant returnDateWithYearOnlyFrom:currentLocation.year];
        
        NSTimeInterval timeIntervalOfLocation = [year timeIntervalSinceReferenceDate];
        NSTimeInterval timeIntervalOfBeginningDate = [beginningDate timeIntervalSinceReferenceDate];
        NSTimeInterval timeIntervalOfEndDate = [endDate timeIntervalSinceReferenceDate];
        
        if (timeIntervalOfLocation >= timeIntervalOfBeginningDate && timeIntervalOfLocation < timeIntervalOfEndDate) {
            [itemsInRange addObject:currentLocation];
        }
    }
    
    return itemsInRange;
}


@end
