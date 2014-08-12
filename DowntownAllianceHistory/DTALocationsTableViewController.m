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
@property (weak, nonatomic) IBOutlet UILabel *formattedLabel;

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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = NO;
    }
    return self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.title;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize:)
                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"year" ascending:YES];
    self.locationsToShow = [self.locationsToShow sortedArrayUsingDescriptors:@[nameSort]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[DTAListCell class]])
    {
        DTAListCell *textCell = (DTAListCell *)cell;
        
        Location *currentLocation = self.locationsToShow[indexPath.row];
        
//        NSString *day = [currentLocation.day stringValue];
//        NSString *month = [currentLocation.month stringValue];
//        NSString *year = [currentLocation.year stringValue];
//        
      NSString *date = [NSString stringWithFormat:@"%@",currentLocation.year];
//        
//        NSString *appendeddate = [currentLocation.titleOfPlaque stringByAppendingString:date];
//        
        textCell.dateLabel.text = date;
        
        textCell.listLabel.text = currentLocation.titleOfPlaque;
        textCell.listLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.locationsToShow count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailTablecell" forIndexPath:indexPath];
    
    // Configure the cell...
//    Location *currentLocation = self.locationsToShow[indexPath.row];
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",currentLocation.titleOfPlaque];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  return 300;
    [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
    
    // Need to set the width of the prototype cell to the width of the table view
    // as this will change when the device is rotated.
    
   // self.prototypeCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(self.prototypeCell.bounds));
    
    [self.prototypeCell layoutIfNeeded];
    
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DTADetailViewController *nextVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Location *selectedLocation = self.locationsToShow[indexPath.row];
    nextVC.locationToBePLotted = selectedLocation;
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
