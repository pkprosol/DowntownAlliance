//
//  DTADetailViewController.h
//  DowntownAllianceHistory
//
//  Created by Viktor Falkner on 7/29/14.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Location.h"

@interface DTADetailViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *arrayOfLocations;

@property (strong, nonatomic) Location *locationToBePLotted;

-(void)plotLocationsOnMap:(Location *)locationToBePlotted;

@end
