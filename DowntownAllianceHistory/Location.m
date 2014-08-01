//
//  Location.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/1/14.
//
//

#import "Location.h"
#import "Decade.h"
#import "Theme.h"


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
    
    if (self.day) {
        self.hasData = [NSNumber numberWithBool:YES];
    }
    
    [self setUpLocationImage];
}

- (void)setUpLocationImage
{
    self.image = [UIImage imageNamed:@"1910s.png"];
    
    // Keys are the idNumber and image name
    NSDictionary *imageMatch = @{@"coh10-28-1886": @"001.tif",
                                 @"coh4-29-1889": @"002.tif",
                                 };
    
    if (imageMatch[self.idNumber]) {
        NSString *imageName = imageMatch[self.idNumber];
        self.image = [UIImage imageNamed:imageName];
    }
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
