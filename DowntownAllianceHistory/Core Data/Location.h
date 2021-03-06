//
//  Location.h
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/7/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Theme, TimeInterval;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * brochureDescription;
@property (nonatomic, retain) NSNumber * day;
@property (nonatomic, retain) NSNumber * hasData;
@property (nonatomic, retain) NSString * idNumber;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * month;
@property (nonatomic, retain) NSString * symbolValue;
@property (nonatomic, retain) NSString * titleOfPlaque;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) TimeInterval *timeInterval;
@property (nonatomic, retain) NSSet *themes;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addThemesObject:(Theme *)value;
- (void)removeThemesObject:(Theme *)value;
- (void)addThemes:(NSSet *)values;
- (void)removeThemes:(NSSet *)values;

- (void)setUpLocationDataWithComponentArrayAndImage:(NSArray *)componentArray;

@end
