//
//  DTAGetRandomNumber.h
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/5/14.
//
//

#import <Foundation/Foundation.h>

@interface DTAGetRandomNumber : NSObject

+ (id)getRandomEntryInArray:(NSArray *)array;

+ (NSInteger)getRandomNumberBetweenMin:(NSInteger)min AndMaxInclusive:(NSInteger)max;

@end
