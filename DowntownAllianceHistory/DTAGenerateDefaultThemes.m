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
                                                @"ForeignDignitaries": @"foreigners.png",
                                                @"Military": @"military.png",
                                                @"Sports": @"sports.png",
                                                @"USHistory": @"UnitedStatesHistory.png",
                                                @"USLeaders": @"USLeaders.png"};
                                                
    return defaultThemeAndImageNames;
}

@end
