//
//  Location.h
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Decade, Theme;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * idNumber;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * symbolValue;
@property (nonatomic, retain) Decade *decade;
@property (nonatomic, retain) Theme *theme;

- (void)setLocationDecade:(Decade *)decade Theme:(Theme *)theme;

@end
