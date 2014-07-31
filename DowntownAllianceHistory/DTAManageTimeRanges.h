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

+ (DTATimeRange *)generateTimeRangeWithStartDate:(NSDate *)startDate AndEndDate:(NSDate *)endDate;

@end
