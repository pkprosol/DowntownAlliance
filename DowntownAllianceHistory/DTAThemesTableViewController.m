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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setSeparatorColor:[UIColor blackColor]];

    DTADataStore *store = [DTADataStore sharedDataStore];
    self.themesArray = store.defaultThemesArray;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.themesArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTAFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"themeCell" forIndexPath:indexPath];
        
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
