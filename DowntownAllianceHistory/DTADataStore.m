////
////  DTADataStore.m
////  DowntownAllianceHistory
////
////  Created by Piotr K Prosol on 7/29/14.
////
////

#import "DTADataStore.h"
#import "DTASetUpDefaultData.h"

@implementation DTADataStore

@synthesize managedObjectContext = _managedObjectContext;

+ (instancetype)sharedDataStore {
    static DTADataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore= [[DTADataStore alloc] init];
    });
    
    return _sharedDataStore;
}

- (NSArray *)fetchDataForEntityName:(NSString *)entityName
{
    NSFetchRequest *fetchDataRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    NSArray *fetchedData = [self.managedObjectContext executeFetchRequest:fetchDataRequest error:nil];
    
    if ([fetchedData count] == 0) {
        [DTASetUpDefaultData setUpDefaultData];
        fetchedData = [self.managedObjectContext executeFetchRequest:fetchDataRequest error:nil];
    }
    
    return fetchedData;
}

- (void)setUpDefaultThemesArray
{
    self.defaultThemesArray = [self fetchDataForEntityName:@"Theme"];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DowntownAllianceHistory.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DowntownAlliance" withExtension:@"momd"];
    
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
