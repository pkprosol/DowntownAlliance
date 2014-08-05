//
//  Theme.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/5/14.
//
//

#import "Theme.h"
#import "Location.h"
#import "DTADataStore.h"

@implementation Theme

@dynamic image;
@dynamic name;
@dynamic order;
@dynamic locations;

+ (Theme *)setUpThemeWithName:(NSString *)name Image:(UIImage *)image Order:(NSInteger)order
{
    DTADataStore *store = [DTADataStore sharedDataStore];
    
    Theme *newTheme = [NSEntityDescription insertNewObjectForEntityForName:@"Theme" inManagedObjectContext:store.managedObjectContext];
    
    newTheme.name = name;
    newTheme.image = image;
    newTheme.order = [NSNumber numberWithInteger: order];
    
    return newTheme;
}

@end
