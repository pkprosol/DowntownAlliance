//
//  DTADataFetchFromCSV.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "DTADataFetchFromCSV.h"
#import "Location.h"
#import "DTADataStore.h"

@implementation DTADataFetchFromCSV

+ (void)importCSV
{
    NSString *rawCSVString = [DTADataFetchFromCSV getCSVFileAndConvertToString];
    NSArray *cleanArray = [DTADataFetchFromCSV getCleanArrayOfCSVFileFromString:rawCSVString];
    NSArray *componentsArray = [DTADataFetchFromCSV getArrayOfArraysWithComponentsFromArray:cleanArray];
    [DTADataFetchFromCSV createLocationObjectsInCoreDataFromComponentsArray:componentsArray];
}

+ (NSString *)getCSVFileAndConvertToString
{
    NSString *filePathString = [[NSBundle mainBundle] pathForResource:@"COH_Coordinates_with_sample_data" ofType:@"csv"];
    NSURL *filePathURL = [NSURL fileURLWithPath:filePathString];
    NSString *stringContentsOfCSV = [NSString stringWithContentsOfURL:filePathURL encoding:NSUTF8StringEncoding error:nil];
    
    return stringContentsOfCSV;
}

+ (NSArray *)getCleanArrayOfCSVFileFromString:(NSString *)CSVFileString
{
    NSArray *linesOfCSVFile = [CSVFileString componentsSeparatedByString:@"\n"];
    NSMutableArray *cleanArray = [NSMutableArray new];
    
    NSCharacterSet *characterset = [NSCharacterSet newlineCharacterSet];
    
    for (NSString *line in linesOfCSVFile) {
        NSString *lineWithoutBackSlashes = [line stringByReplacingOccurrencesOfString:@"\""  withString:@""];
        NSString *cleanLine = [lineWithoutBackSlashes stringByTrimmingCharactersInSet:characterset];
        
        [cleanArray addObject:cleanLine];
    }
    
    return cleanArray;
}

+ (NSArray *)getArrayOfArraysWithComponentsFromArray:(NSArray *)cleanArray
{
    NSMutableArray *componentsArray = [NSMutableArray new];
    
    for (NSString *lineItem in cleanArray) {
        NSArray *componentsSeparatedByString = [lineItem componentsSeparatedByString:@","];
        [componentsArray addObject:componentsSeparatedByString];
    }
    
    return componentsArray;
}

+ (void)createLocationObjectsInCoreDataFromComponentsArray:(NSArray *)componentsArray
{
    DTADataStore *store = [DTADataStore sharedDataStore];
    
    for (NSArray *locationItemComponentsArray in componentsArray) {
        if (![locationItemComponentsArray[0] isEqualToString:@"ID"]) {
            Location *newLocation = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:store.managedObjectContext];
            [newLocation setUpLocationDataWithComponentArray:locationItemComponentsArray];
            NSLog(@"%@", newLocation);
        }
    }
    
    
}

@end
