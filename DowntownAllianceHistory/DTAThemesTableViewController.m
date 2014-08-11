//
//  DTACategoriesTableViewController.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/30/14.
//
//

#import "DTAThemesTableViewController.h"
#import "DTAFilterCell.h"
#import "DTALocationsTableViewController.h"
#import "UITabBarController+hidableTab.h"
#import "DTADataStore.h"
#import "DTAThemeCell.h"
#import "DTAAppDelegate.h"
#import "Theme.h"
#import "DTALocationsTableViewController.h"

@interface DTAThemesTableViewController ()

@end

@implementation DTAThemesTableViewController

{
    CGFloat startContentOffset;
    CGFloat lastContentOffset;
    BOOL hidden;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        hidden = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DTADataStore *store = [DTADataStore sharedDataStore];
    self.themesArray = store.defaultThemesArray;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setSeparatorColor:[UIColor blackColor]];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.tabBarController setTabBarHidden:hidden
//                                  animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - The Magic!

-(void)expand
{
    if(hidden)
        return;
    
    hidden = YES;
    
    //    [self.tabBarController setTabBarHidden:YES
    //                                  animated:YES];
    
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
    
    //    [self.tabBarController setTabBarHidden:NO
    //                                  animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO
                                             animated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    startContentOffset = lastContentOffset = scrollView.contentOffset.y;
    //NSLog(@"scrollViewWillBeginDragging: %f", scrollView.contentOffset.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat differenceFromStart = startContentOffset - currentOffset;
    CGFloat differenceFromLast = lastContentOffset - currentOffset;
    lastContentOffset = currentOffset;
    
//    NSLog(@"Offest: %f",currentOffset);
//    NSLog(@"start: %f", differenceFromStart);
//    NSLog(@"last: %f",differenceFromLast);
    
    if((differenceFromStart) < 0)
    {
        // scroll up
        if(scrollView.isTracking && (abs(differenceFromLast)>20))
        {
            [self expand];
            NSLog(@"Expanding");
        }
    }
    else {
        if(scrollView.isTracking && (abs(differenceFromLast)>20))
        {
            [self contract];
            NSLog(@"contracting");
        }
    }
    
}


#pragma mark - Table view delegate



#pragma mark - The Magic!

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
    // Return the number of rows in the section.
    return [self.themesArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTAFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"themeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Theme *themeInCell = self.themesArray[indexPath.row];
    
    cell.filterCellImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.filterCellImageView.image = themeInCell.image;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DTALocationsTableViewController *nextViewController = [segue destinationViewController];
    NSIndexPath *indexSelected = [self.tableView indexPathForSelectedRow];
    
    Theme *themeSelected = self.themesArray[indexSelected.row];
    nextViewController.locationsToShow = [themeSelected.locations allObjects];
}


@end
