//
//  Theme.h
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/1/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location;

@interface Theme : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSSet *locations;
@end

@interface Theme (CoreDataGeneratedAccessors)

- (void)addLocationsObject:(Location *)value;
- (void)removeLocationsObject:(Location *)value;
- (void)addLocations:(NSSet *)values;
- (void)removeLocations:(NSSet *)values;

+ (Theme *)setUpThemeWithName:(NSString *)name Image:(UIImage *)image;

@end
