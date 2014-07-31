//
//  DTADateFormatterAssistant.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/31/14.
//
//

#import "DTADateFormatterAssistant.h"

@implementation DTADateFormatterAssistant

+ (NSDate *)returnDateWithYearOnlyFrom:(NSNumber *)year
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"MM-dd-yyyy"];
#warning fix me later
    NSString *yearString = [NSString stringWithFormat:@"01-01-%@",year];
    NSDate *date = [dateFormat dateFromString:yearString];
    
    return date;
}

@end
