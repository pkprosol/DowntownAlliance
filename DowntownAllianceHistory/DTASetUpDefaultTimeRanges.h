//
//  DTAManageTimeRanges.h
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/31/14.
//
//

#import <Foundation/Foundation.h>
#import "DTATimeRange.h"

@interface DTASetUpDefaultTimeRanges : NSObject

+ (void)setUpArrayOfDefaultTimeRanges;
+ (DTATimeRange *)generateTimeRangeWithName:(NSString *)name StartDate:(NSDate *)startDate EndDate:(NSDate *)endDate Image:(UIImage *)image;

// Receives array with beginning, intermediate, and final dates and generates time intervals
+ (NSArray *)findItemsInTimeRange:(DTATimeRange *)range;

@end 
