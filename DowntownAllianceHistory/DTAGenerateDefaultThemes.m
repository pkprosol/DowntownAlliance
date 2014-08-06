//
//  DTAGenerateDefaultThemes.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/1/14.
//
//

#import "DTAGenerateDefaultThemes.h"
#import "Theme.h"

@implementation DTAGenerateDefaultThemes

+ (NSDictionary *)generateDefaultDictionaryOfThemesAndImages
{
    // Key is the theme name, and the value is the image, and priority for each (lowest numbers first)
    NSDictionary *defaultThemeAndImageNames = @{@"Aviation": @[@"Aviation.png", @0],
                                                @"ForeignDignitaries": @[@"foreignDig.png", @3],
                                                @"Military": @[@"military.png", @4],
                                                @"Sports": @[@"sports.png", @5],
                                                @"USHistory": @[@"USHistory.png", @1],
                                                @"USLeaders": @[@"USleaders.png", @2]};
                                                
    return defaultThemeAndImageNames;
}

@end
