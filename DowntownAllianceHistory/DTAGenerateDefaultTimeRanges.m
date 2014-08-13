//
//  DTAGenerateDefaultTimeRanges.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/31/14.
//
//

#import "DTAGenerateDefaultTimeRanges.h"

@implementation DTAGenerateDefaultTimeRanges

+ (NSDictionary *)generateDefaultDictionaryOfTimeIntervals
{
    // Decades input dictionary takes a start date string (must be in format "mm-dd-yyyy") and label for the time period
    
    NSDictionary *datesDictionary = @{@"01-01-1800":@"pre-1900s",
                                      
                                      @"01-01-1910":@"1910s",
                                      @"01-01-1920":@"1920s",
                                      @"01-01-1930":@"1930s",
                                      @"01-01-1940":@"1940s",
                                      @"01-01-1950":@"1950s",
                                      @"01-01-1960":@"1960s",
                                      @"01-01-1970":@"1970s",
                                      @"01-01-1980":@"1980s",
                                      @"01-01-1990":@"1990s",
                                      @"01-01-2000":@"2000s",
                                      @"01-01-2010":@"2010s"};
    
    return datesDictionary;
}

+ (NSArray *)generateDefaultArrayOfImagesToMatchTimeIntervals
{
    // Images must match the order of and correspond to the time labels in default dictionary of time intervals
    
    NSArray *images = @[[UIImage imageNamed:@"pre1910.png"],
                        [UIImage imageNamed:@"1910.png"],
                        [UIImage imageNamed:@"1920.png"],
                        [UIImage imageNamed:@"1930.png"],
                        [UIImage imageNamed:@"1940.png"],
                        [UIImage imageNamed:@"1950.png"],
                        [UIImage imageNamed:@"1960.png"],
                        [UIImage imageNamed:@"1970.png"],
                        [UIImage imageNamed:@"1980.png"],
                        [UIImage imageNamed:@"1990.png"],
                        [UIImage imageNamed:@"2000.png"],
                        [UIImage imageNamed:@"2010.png"]];
    
    return images;
}

@end
