//
//  DTADataFetchFromCSV.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "DTASetUpDefaultData.h"
#import "Location.h"
#import "DTADataStore.h"
#import "DTASetUpDefaultTimeRanges.h"
#import "DTASetUpDefaultThemes.h"

@implementation DTASetUpDefaultData

+ (void)setUpDefaultData
{
    NSString *rawCSVString = [DTASetUpDefaultData getCSVFileAndConvertToString];
    NSArray *cleanArray = [DTASetUpDefaultData getCleanArrayOfCSVFileFromString:rawCSVString];
    NSArray *componentsArray = [DTASetUpDefaultData getArrayOfArraysWithComponentsFromArray:cleanArray];
    
    [DTASetUpDefaultTimeRanges setUpArrayOfDefaultTimeRanges];
    [DTASetUpDefaultThemes setUpArrayOfThemesWithNameAndImage];
    
    [DTASetUpDefaultData createLocationObjectsInCoreDataFromComponentsArray:componentsArray];
}

+ (NSString *)getCSVFileAndConvertToString
{
    NSString *filePathString = [[NSBundle mainBundle] pathForResource:@"COH2" ofType:@"csv"];
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
    
    NSArray *cleanComponentsArray = [DTASetUpDefaultData cleanAsterisksFromArray:componentsArray];
    
    return cleanComponentsArray;
}

+ (NSArray *)cleanAsterisksFromArray:(NSArray *)componentsArray
{
    NSMutableArray *cleanArrayOfComponentArrays = [NSMutableArray new];
    
    for (NSArray *locationComponents in componentsArray) {
        
        NSMutableArray *cleanLocationComponentsArray = [NSMutableArray new];
    
        for (NSString *component in locationComponents) {
            
            NSString *cleanComponent = [component stringByReplacingOccurrencesOfString:@"#" withString:@","];
            [cleanLocationComponentsArray addObject:cleanComponent];

        }
        
        [cleanArrayOfComponentArrays addObject:cleanLocationComponentsArray];
    }
    
    return cleanArrayOfComponentArrays;
}

+ (void)createLocationObjectsInCoreDataFromComponentsArray:(NSArray *)componentsArray
{
    DTADataStore *store = [DTADataStore sharedDataStore];
    
    for (NSArray *locationItemComponentsArray in componentsArray) {
        
        BOOL isNotFirstRow = ![locationItemComponentsArray[0] isEqualToString:@"ID"];
        BOOL isNotBlank = [locationItemComponentsArray[7] length] > 0;
        
        if (isNotFirstRow && isNotBlank) {
            Location *newLocation = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:store.managedObjectContext];
            [newLocation setUpLocationDataWithComponentArrayAndImage:locationItemComponentsArray];
        }
    }
}

@end
