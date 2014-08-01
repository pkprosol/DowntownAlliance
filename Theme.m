//
//  Theme.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/1/14.
//
//

#import "Theme.h"
#import "Location.h"
#import "DTADataStore.h"

@implementation Theme

@dynamic name;
@dynamic image;
@dynamic locations;

+ (NSArray *)setUpThemeWithNameAndImage
{
    DTADataStore *store = [DTADataStore sharedDataStore];
    NSMutableArray *themes = [NSMutableArray new];
    
    NSDictionary *themesDictionary = 
    
    Theme *newTheme = [NSEntityDescription insertNewObjectForEntityForName:@"Theme" inManagedObjectContext:store.managedObjectContext];
    
    newTheme.name = name;
    newTheme.image = image;
}

@end
