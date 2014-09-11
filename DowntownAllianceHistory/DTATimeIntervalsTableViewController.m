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
#import "UITabBarController+hidableTab.h"
#import "DTATimeRange.h"
#import "DTASetUpDefaultTimeRanges.h"

@interface DTATimeIntervalsTableViewController ()

@end

@implementation DTATimeIntervalsTableViewController
{
    CGFloat startContentOffset;
    CGFloat lastContentOffset;
    BOOL hidden;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"SOCIAL APP!", @"");
        hidden = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    hidden=NO;
    self.tableView.backgroundColor = [UIColor blackColor];
    
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setSeparatorColor:[UIColor blackColor]];
   
    
    self.arrayOfTimeIntervals = [DTASetUpDefaultTimeRanges getAndProcessDefaultTimeRanges];
    self.arrayOfImages = [NSMutableArray new];
    
    for (DTATimeRange *timeRange in self.arrayOfTimeIntervals) {
        [self.arrayOfImages addObject:timeRange.imageForRange];
    }
    
    DTAAppDelegate *appDelegate = (DTAAppDelegate *)[[UIApplication sharedApplication ] delegate];
    
    [appDelegate setUpFromGeoFence];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayOfImages count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTAFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    UIImage *imageOfDecade = self.arrayOfImages[indexPath.row];
    
    cell.filterCellImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.filterCellImageView.image = imageOfDecade;
    
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)expand
{
    if(hidden)
        return;
    
    hidden = YES;
    
    [self.navigationController setNavigationBarHidden:YES
                                             animated:YES];
}

-(void)contract
{
    if(!hidden)
    {
        return;
    }
    
    hidden = NO;
    
    [self.navigationController setNavigationBarHidden:NO
                                             animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    startContentOffset = lastContentOffset = scrollView.contentOffset.y;
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
