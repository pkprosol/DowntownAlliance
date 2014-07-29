//
//  Location.h
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic) CGFloat latitude;
@property (nonatomic) CGFloat longitude;
@property (strong, nonatomic) NSString * idNumber;

- (instancetype)initWithComponentStringArray:(NSArray *)componentString;

@end
