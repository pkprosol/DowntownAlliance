//
//  DTAViewController.h
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DTASetUpDefaultData.h"
#import "Location.h"

@interface DTAMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) NSArray *arrayOfLocations;

-(void)plotLocationsOnMap:(Location *)locationToBePlotted;
-(void)plotArrayOfLocationsOnMap:(NSArray *)arrayOfLocations;

@end
