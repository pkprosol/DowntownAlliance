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

+ (Theme *)setUpThemeWithName:(NSString *)name Image:(UIImage *)image
{
    DTADataStore *store = [DTADataStore sharedDataStore];
    
    Theme *newTheme = [NSEntityDescription insertNewObjectForEntityForName:@"Theme" inManagedObjectContext:store.managedObjectContext];
    
    newTheme.name = name;
    newTheme.image = image;
    
    return newTheme;
}

@end
