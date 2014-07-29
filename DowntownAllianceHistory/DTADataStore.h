//
//  DTADataStore.h
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import <Foundation/Foundation.h>

@interface DTADataStore : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (instancetype) sharedDataStore;

- (void) saveContext;

@end
