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
#import "DTAScrollingDetailTable.h"
#import "DTAResizingCell.h"


@interface DTADetailViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) DTAResizingCell *prototypeCell;
@property (strong, nonatomic) NSMutableArray *arrayOfLocations;
@property (strong, nonatomic) Location *locationToBePLotted;
@property (strong, nonatomic) NSMutableArray *stuffToDisplay;
@property (weak, nonatomic) IBOutlet DTAScrollingDetailTable *scrollingTableView;

-(void)plotLocationsOnMap:(Location *)locationToBePlotted;

@end
