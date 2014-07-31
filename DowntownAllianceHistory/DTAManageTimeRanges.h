//
//  DTAManageTimeRanges.h
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/31/14.
//
//

#import <Foundation/Foundation.h>
#import "DTATimeRange.h"

@interface DTAManageTimeRanges : NSObject

+ (DTATimeRange *)generateTimeRangeWithName:(NSString *)name StartDate:(NSDate *)startDate EndDate:(NSDate *)endDate Image:(UIImage *)image;

// Receives array with beginning, intermediate, and final dates and generates time intervals
+ (NSArray *)getAndProcessDefaultTimeRanges;

+ (NSArray *)findItemsInTimeRange:(DTATimeRange *)range;

@end 
