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

@end

@implementation DTADetailViewController

- (DTAResizingCell *)prototypeCell
{
    if (!_prototypeCell)
    {
        _prototypeCell = [_scrollingTableView dequeueReusableCellWithIdentifier:@"detailCell"];
    }
    return _prototypeCell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize:)
                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    [self plotLocationsOnMap:self.locationToBePLotted];
    
    CGFloat latitudeCenterPoint = [self.locationToBePLotted.latitude floatValue];
    CGFloat longitudeCenterPoint = [self.locationToBePLotted.longitude floatValue];
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitudeCenterPoint, longitudeCenterPoint);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 150.0, 150.0);
    
    [self.mapOutlet setRegion:[self.mapOutlet regionThatFits:region] animated:YES];
    
    [self.tableViewOutlet registerNib:[UINib nibWithNibName:@"DTAImageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"pictureImage"];
    
    self.mapOutlet.delegate = self;

    self.tableViewOutlet.backgroundColor = [UIColor clearColor];
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
    
    if (indexPath.row < 2)
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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

@end
