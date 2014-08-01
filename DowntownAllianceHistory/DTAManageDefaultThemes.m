//
//  DTAManageDefaultThemes.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/1/14.
//
//

#import "DTAManageDefaultThemes.h"
#import "DTAGenerateDefaultThemes.h"
#import "Theme.h"

@implementation DTAManageDefaultThemes

+ (NSArray *)setUpArrayOfThemesWithNameAndImage
{
    NSMutableArray *themes = [NSMutableArray new];
    
    NSDictionary *themesDictionary = [DTAGenerateDefaultThemes generateDefaultDictionaryOfThemesAndImages];
    NSArray *allKeys = [themesDictionary allKeys];
    
    for (NSString *key in allKeys) {
        NSString *name = key;
        UIImage *image = [UIImage imageNamed:themesDictionary[key]];
        
        Theme *newTheme = [Theme setUpThemeWithName:name Image:image];
        
        [themes addObject:newTheme];
    }
    
    return themes;
}

@end
