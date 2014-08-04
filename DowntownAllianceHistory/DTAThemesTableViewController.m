//
//  DTACategoriesTableViewController.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/30/14.
//
//

#import "DTAThemesTableViewController.h"
#import "DTAFilterCell.h"
#import "DTATableViewController.h"
#import "UITabBarController+hidableTab.h"
#import "DTAManageDefaultThemes.h"
#import "DTAThemeCell.h"


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
    
    self.themesArray = [DTAManageDefaultThemes setUpArrayOfThemesWithNameAndImage];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    NSLog(@"Offest: %f",currentOffset);
    NSLog(@"start: %f", differenceFromStart);
    NSLog(@"last: %f",differenceFromLast);
    
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

//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//}
//
//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
//{
//    [self contract];
//    return YES;
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
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


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
