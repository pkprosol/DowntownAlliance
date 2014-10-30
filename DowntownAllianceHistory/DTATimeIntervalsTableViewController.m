//
//  DTADecadesTableViewController.m
//  DowntownAllianceHistory
//
//  Created by Viktor Falkner on 7/30/14.
//
//

#import "DTATimeIntervalsTableViewController.h"
#import "DTAFilterCell.h"
#import "DTALocationsTableViewController.h"
#import "DTATimeRange.h"
#import "DTADataStore.h"
#import "DTASetUpDefaultTimeRanges.h"

@interface DTATimeIntervalsTableViewController ()

@end

@implementation DTATimeIntervalsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor blackColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   
    DTADataStore *dataStore = [DTADataStore sharedDataStore];
    
    self.arrayOfTimeIntervals = dataStore.defaultTimeIntervalsArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayOfTimeIntervals count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTAFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    UIImage *imageOfDecade = [self.arrayOfTimeIntervals[indexPath.row] imageForRange];
    
    cell.filterCellImageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.filterCellImageView.image = imageOfDecade;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"decadesDetails"]) {
        DTALocationsTableViewController *nextVC = [segue destinationViewController];
        NSIndexPath *indexSelected = [self.tableView indexPathForSelectedRow];
        DTATimeRange *timeRangeSelected = self.arrayOfTimeIntervals[indexSelected.row];
        
        nextVC.title = timeRangeSelected.nameOfRange;
        nextVC.locationsToShow = [DTASetUpDefaultTimeRanges findItemsInTimeRange:timeRangeSelected];
    }
}

@end
