//
//  DTATimeRange.h
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/31/14.
//
//

#import <Foundation/Foundation.h>

@interface DTATimeRange : NSObject

@property (strong, nonatomic) NSString *nameOfRange;
@property (nonatomic) NSInteger beginningTime;
@property (nonatomic) NSInteger lengthOfTime;

@end
