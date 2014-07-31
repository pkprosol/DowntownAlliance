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
@property (nonatomic) NSDate *beginningDate;
@property (nonatomic) NSDate *endDate;
@property (strong, nonatomic) UIImage *imageForRange;

- (instancetype)init;
- (instancetype)initWithName:(NSString *)nameOfRange BeginningDate:(NSDate *)beginningDate EndDate:(NSDate *)endDate Image:(UIImage *)imageForRange;

@end
