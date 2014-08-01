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
    
    NSDictionary *datesDictionary = @{@"01-01-1899":@"pre-1920s",
                                      @"01-01-1920":@"1920s",
                                      @"01-01-1930":@"1930s",
                                      @"01-01-1940":@"1940s",
                                      @"01-01-1950":@"1950s",
                                      @"01-01-1960":@"1960s",
                                      @"01-01-1970":@"1970s",
                                      @"01-01-1980":@"1980s",
                                      @"01-01-1990":@"1990s",
                                      @"01-01-2000":@"2000s"};
    
    return datesDictionary;
}

+ (NSArray *)generateDefaultArrayOfImagesToMatchTimeIntervals
{
    // Images must match the order of and correspond to the time labels in default dictionary of time intervals
    
    NSArray *images = @[[UIImage imageNamed:@"1910s.png"],
                        [UIImage imageNamed:@"1920s.png"],
                        [UIImage imageNamed:@"1930s.png"],
                        [UIImage imageNamed:@"1940s.png"],
                        [UIImage imageNamed:@"1950s.png"],
                        [UIImage imageNamed:@"1960s.png"],
                        [UIImage imageNamed:@"1970s.png"],
                        [UIImage imageNamed:@"1980s.png"],
                        [UIImage imageNamed:@"1990s.png"],
                        [UIImage imageNamed:@"2000s.png"]];
    
    return images;
}

@end
