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
@property (strong, nonatomic) NSArray *defaultThemesArray;

+ (instancetype) sharedDataStore;

- (NSArray *)fetchDataForEntityName:(NSString *)entityName;
- (void)saveContext;

@end
