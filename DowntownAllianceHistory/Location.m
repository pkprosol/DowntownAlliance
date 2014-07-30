//
//  Location.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/30/14.
//
//

#import "Location.h"
#import "Decade.h"
#import "Theme.h"
#import "DTADataStore.h"

@implementation Location

@dynamic name;
@dynamic idNumber;
@dynamic symbolValue;
@dynamic latitude;
@dynamic longitude;
@dynamic month;
@dynamic day;
@dynamic year;
@dynamic details;
@dynamic hasData;
@dynamic theme;
@dynamic decade;

- (void)setUpLocationDataWithComponentArray:(NSArray *)componentArray
{
    self.idNumber = componentArray[0];
    self.symbolValue = componentArray[1];
    self.latitude = [self convertStringWithFloatToNSNumber:componentArray[2]];
    self.longitude = [self convertStringWithFloatToNSNumber:componentArray[3]];
    self.month = [self convertStringWithIntegerToNSNumber:componentArray[4]];
    self.day = [self convertStringWithIntegerToNSNumber:componentArray[5]];
    self.year = [self convertStringWithIntegerToNSNumber:componentArray[6]];
    self.name = componentArray[7];
    self.details = componentArray[8];
    
    if (self.day) {
        self.hasData = [NSNumber numberWithBool:YES];
    }
    
    DTADataStore *store = [DTADataStore sharedDataStore];
    
    Decade *decadeForLocation = [NSEntityDescription insertNewObjectForEntityForName:@"Decade" inManagedObjectContext:store.managedObjectContext];
    
}

- (NSString *)getDecadeNameForYear:(NSNumber *)year
//{
//    NSinteger *yearInteger = ..... year;
//    if (year > 1899 && < year <1910) {
//        return @"1900s";
//    } etc.
//}

- (NSNumber *)convertStringWithIntegerToNSNumber:(NSString *)string
{
    NSInteger integerFromString = [string integerValue];
    NSNumber *numberFromInteger = [NSNumber numberWithInteger:integerFromString];
    
    return numberFromInteger;
}

- (NSNumber *)convertStringWithFloatToNSNumber:(NSString *)string
{
    CGFloat floatFromString = [string floatValue];
    NSNumber *numberFromFloat = [NSNumber numberWithFloat:floatFromString];
    
    return numberFromFloat;
}

@end
