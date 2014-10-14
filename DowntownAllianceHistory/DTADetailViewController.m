//
//  DTADetailViewController.m
//  DowntownAllianceHistory
//
//  Created by Viktor Falkner on 7/29/14.
//
//

#import "DTADetailViewController.h"
#import "DTAPlaqueImageCell.h"



@interface DTADetailViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapOutlet;
@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@end

@implementation DTADetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (DTAResizingCell *)prototypeCell
{
    if (!_prototypeCell)
    {
        _prototypeCell = [self.scrollingTableView dequeueReusableCellWithIdentifier:@"detailCell"];
    }
    return _prototypeCell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize:)
                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    //Plot Passed Locations
    [self plotLocationsOnMap:self.locationToBePLotted];
    
    
    //Float Values for coordinates
    CGFloat latitudeCenterPoint = [self.locationToBePLotted.latitude floatValue];
    CGFloat longitudeCenterPoint = [self.locationToBePLotted.longitude floatValue];
    
    //make coordinate
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitudeCenterPoint, longitudeCenterPoint);
    //set Region To zoom
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 150.0, 150.0);
    
    //Set region to map
    [self.mapOutlet setRegion:[self.mapOutlet regionThatFits:region] animated:YES];
    
    //load XiB
    [self.tableViewOutlet registerNib:[UINib nibWithNibName:@"DTAImageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"pictureImage"];
    
    
    self.mapOutlet.delegate = self;
    
    self.tableViewOutlet.backgroundColor = [UIColor clearColor];
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.stuffToDisplay = [[NSMutableArray alloc]init];
    [self.stuffToDisplay addObject:self.locationToBePLotted.titleOfPlaque];
    [self.stuffToDisplay addObject:self.locationToBePLotted.brochureDescription];
    
    if (self.locationToBePLotted.image) {
        [self.stuffToDisplay addObject:self.locationToBePLotted.image];
    }
    self.tableViewOutlet.delegate = self;
    self.tableViewOutlet.dataSource = self;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}
- (void)didChangePreferredContentSize:(NSNotification *)notification
{
    [self.scrollingTableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.stuffToDisplay count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    if (indexPath.row <2)
    {
        
        [self configureCell:cell forRowAtIndexPath:indexPath];
    }
    
    
    if (indexPath.row == 2) {
        if(self.locationToBePLotted.image){
            
            DTAPlaqueImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picture"forIndexPath:indexPath];
            
            cell.plaqueImageView.contentMode = UIViewContentModeScaleAspectFill;
            cell.plaqueImageView.image = self.locationToBePLotted.image;
        }
        
        
    }
    
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[DTAResizingCell class]])
    {
        DTAResizingCell *textCell = (DTAResizingCell *)cell;
        
        textCell.lineLabel.text = [self.stuffToDisplay objectAtIndex:indexPath.row];
        textCell.lineLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2)
    {
        return 250;
    }
    else
    {
        [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
        
        [self.prototypeCell layoutIfNeeded];
        
        CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height+1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)plotLocationsOnMap:(Location *)locationToBePlotted
{
    MKPointAnnotation *pointToAnnotate = [[MKPointAnnotation alloc]init];
    
    CGFloat latitudeFloat = [locationToBePlotted.latitude floatValue];
    CGFloat longitudeFloat = [locationToBePlotted.longitude floatValue];
    
    pointToAnnotate.coordinate = CLLocationCoordinate2DMake(latitudeFloat, longitudeFloat);
    pointToAnnotate.title = locationToBePlotted.titleOfPlaque;
    
    [self.mapOutlet addAnnotation:pointToAnnotate];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableViewOutlet.contentInset = UIEdgeInsetsMake(self.tableViewOutlet.frame.size.height-40, 0, 0, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < self.mapOutlet.frame.size.height*-1 ) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, self.mapOutlet.frame.size.height*-1)];
        
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.tableViewOutlet.delegate = nil;
    self.tableViewOutlet.dataSource = nil;
}

@end
