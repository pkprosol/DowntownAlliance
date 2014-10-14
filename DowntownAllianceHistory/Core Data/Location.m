//
//  Location.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/7/14.
//
//

#import "Location.h"
#import "Theme.h"
#import "TimeInterval.h"
#import "DTAGetRandomNumber.h"
#import "DTADataStore.h"

@implementation Location

@dynamic brochureDescription;
@dynamic day;
@dynamic hasData;
@dynamic idNumber;
@dynamic image;
@dynamic latitude;
@dynamic longitude;
@dynamic month;
@dynamic symbolValue;
@dynamic titleOfPlaque;
@dynamic year;
@dynamic timeInterval;
@dynamic themes;

- (void)setUpLocationDataWithComponentArrayAndImage:(NSArray *)componentArray
{
    self.idNumber = componentArray[0];
    self.symbolValue = componentArray[1];
    self.latitude = [self convertStringWithFloatToNSNumber:componentArray[2]];
    self.longitude = [self convertStringWithFloatToNSNumber:componentArray[3]];
    self.month = [self convertStringWithIntegerToNSNumber:componentArray[4]];
    self.day = [self convertStringWithIntegerToNSNumber:componentArray[5]];
    self.year = [self convertStringWithIntegerToNSNumber:componentArray[6]];

    self.titleOfPlaque = componentArray[7];
    self.brochureDescription = componentArray[8];
    
    NSString *imageNamesString = componentArray[9];
    [self setImageFromNamesString:imageNamesString];
    
    NSString *themesString = componentArray[10];
    [self setThemesFromInputString:themesString];
    
    if (self.day) {
        self.hasData = [NSNumber numberWithBool:YES];
    }
}

- (void)setImageFromNamesString:(NSString *)imageNames
{
    if ([imageNames length] > 0) {
        NSArray *imageNamesArray = [self getCleanArrayOfStringComponents:imageNames];
        NSString *randomImageName = [DTAGetRandomNumber getRandomEntryInArray:imageNamesArray];
        self.image = [UIImage imageNamed:randomImageName];
    } else {
        self.image = nil;
    }
}

- (void)setThemesFromInputString:(NSString *)inputString
{
    if ([inputString length] > 0) {
        NSArray *themeNamesArray = [self getCleanArrayOfStringComponents:inputString];
        
        DTADataStore *store = [DTADataStore sharedDataStore];
        NSArray *themes = store.defaultThemesArray;

        for (NSString *themeName in themeNamesArray) {
            for (Theme *theme in themes) {
                if ([theme.name isEqualToString:themeName]) {
                    [self addThemesObject:theme];
                }
            }
        }
    }
}

- (NSArray *)getCleanArrayOfStringComponents:(NSString *)inputString
{
    inputString = [self cleanWhiteSpaceFromString:inputString];
    NSArray *componentsArray = [self separateStringByCommaIntoArray:inputString];
    
    return componentsArray;
}

- (NSString *)cleanWhiteSpaceFromString:(NSString *)inputString
{
    return [inputString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSArray *)separateStringByCommaIntoArray:(NSString *)inputString
{
    return [inputString componentsSeparatedByString:@","];
}

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
