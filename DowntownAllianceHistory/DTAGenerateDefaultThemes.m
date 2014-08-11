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
    NSDictionary *defaultThemeAndImageNames = @{@"aviation": @[@"Aviation.png", @0],
                                                @"foreigndignitaries": @[@"foreignDig.png", @3],
                                                @"military": @[@"military.png", @4],
                                                @"sports": @[@"sports.png", @5],
                                                @"ushistory": @[@"USHistory.png", @1],
                                                @"usleaders": @[@"USleaders.png", @2]};
                                                
    return defaultThemeAndImageNames;
}

@end
