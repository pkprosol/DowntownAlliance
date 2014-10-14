//
//  DTATableViewController.m
//  DowntownAllianceHistory
//
//  Created by flatiron on 7/30/14.
//
//

#import "DTALocationsTableViewController.h"
#import "Location.h"
#import "DTADetailViewController.h"

@interface DTALocationsTableViewController ()

@end

@implementation DTALocationsTableViewController

- (DTAListCell *)prototypeCell
{
    if (!_prototypeCell)
    {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"detailTablecell"];
    }
    return _prototypeCell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.title;
    
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"year" ascending:YES];
    self.locationsToShow = [self.locationsToShow sortedArrayUsingDescriptors:@[nameSort]];
}

#pragma mark - Table view data source

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[DTAListCell class]])
    {
        DTAListCell *textCell = (DTAListCell *)cell;
        
        Location *currentLocation = self.locationsToShow[indexPath.row];
        
        NSString *date = [NSString stringWithFormat:@"%@",currentLocation.year];
        
        textCell.dateLabel.text = date;
        textCell.listLabel.text = currentLocation.titleOfPlaque;
//        textCell.listLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.locationsToShow count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailTablecell" forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
    
    [self.prototypeCell layoutIfNeeded];
    
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DTADetailViewController *nextVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Location *selectedLocation = self.locationsToShow[indexPath.row];
    nextVC.locationToBePlotted = selectedLocation;
}

@end
