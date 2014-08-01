//
//  DTATableViewController.h
//  DowntownAllianceHistory
//
//  Created by flatiron on 7/30/14.
//
//

#import <UIKit/UIKit.h>
#import "Decade.h"
#import "Theme.h"

@interface DTATableViewController : UITableViewController

@property (strong, nonatomic) NSArray *locationsToShow;
@property (strong, nonatomic) NSString *title;


@end
