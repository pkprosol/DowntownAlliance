//
//  DTATableViewController.h
//  DowntownAllianceHistory
//
//  Created by flatiron on 7/30/14.
//
//

#import <UIKit/UIKit.h>
#import "DTAListCell.h"

@interface DTALocationsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *locationsToShow;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) DTAListCell *prototypeCell;

@end
