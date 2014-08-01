//
//  DTAGenerateDefaultThemes.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/1/14.
//
//

#import "DTAGenerateDefaultThemes.h"

@implementation DTAGenerateDefaultThemes

+ (NSDictionary *)generateDefaultDictionaryOfThemesAndImages
{
    // Key is the theme name, and the value is the image for each
    NSDictionary *defaultThemeAndImageNames = @{@"Aviation": @"Aviation.png",
                                                @"ForeignDignitaries": @"ForeignDignitaries.png",
                                                @"Military": @"Military.png",
                                                @"Sports": @"Sports.png",
                                                @"USHistory": @"USHistory.png",
                                                @"USLeaders": @"USLeaders.png"};
                                                
    return defaultThemeAndImageNames;
}

@end
