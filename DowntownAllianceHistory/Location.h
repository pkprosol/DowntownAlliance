//
//  Location.h
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/30/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Decade, Theme;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * idNumber;
@property (nonatomic, retain) NSString * symbolValue;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * month;
@property (nonatomic, retain) NSNumber * day;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSNumber * hasData;
@property (nonatomic, retain) Theme *theme;
@property (nonatomic, retain) Decade *decade;

- (void)setUpLocationDataWithComponentArray:(NSArray *)componentArray;

@end
