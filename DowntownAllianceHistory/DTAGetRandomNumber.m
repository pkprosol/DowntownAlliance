//
//  DTAGetRandomNumber.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/5/14.
//
//

#import "DTAGetRandomNumber.h"

@implementation DTAGetRandomNumber

+ (id)getRandomEntryInArray:(NSArray *)array
{
    NSInteger arrayCount = [array count];
    NSInteger arrayCountMinusOne = arrayCount--;
    NSInteger randomIndex = [DTAGetRandomNumber getRandomNumberBetweenMin:0 AndMaxInclusive:arrayCountMinusOne];
        
    return array[randomIndex];
}

+ (NSInteger)getRandomNumberBetweenMin:(NSInteger)min AndMaxInclusive:(NSInteger)max;
{
    NSInteger random = arc4random() % max + min;
    
    return random;
}

@end
