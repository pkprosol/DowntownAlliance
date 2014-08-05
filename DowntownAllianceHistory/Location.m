//
//  Location.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/1/14.
//
//

#import "Location.h"
#import "TimeInterval.h"
#import "Theme.h"
#import "DTAGetRandomNumber.h"


@implementation Location

@dynamic brochureDescription;
@dynamic day;
@dynamic hasData;
@dynamic idNumber;
@dynamic latitude;
@dynamic longitude;
@dynamic month;
@dynamic symbolValue;
@dynamic titleOfPlaque;
@dynamic year;
@dynamic image;
@dynamic decade;
@dynamic theme;

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
    
    if (self.day) {
        self.hasData = [NSNumber numberWithBool:YES];
    }
}

- (void)setImageFromNamesString:(NSString *)imageNames
{
    if ([imageNames length] > 0) {
        NSArray *imageNamesArray = [self imageNameComponentsFromString:imageNames];
        NSString *randomImageName = [DTAGetRandomNumber getRandomEntryInArray:imageNamesArray];
        self.image = [UIImage imageNamed:randomImageName];
    } else {
        self.image = nil;
    }
}

- (NSArray *)imageNameComponentsFromString:(NSString *)imageNames
{
    imageNames = [imageNames stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray *imageNamesArray = [imageNames componentsSeparatedByString:@","];
    
    return imageNamesArray;
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
