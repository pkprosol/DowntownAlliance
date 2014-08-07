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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    self.tableViewOutlet.delegate = self;
    self.tableViewOutlet.dataSource = self;
    self.tableViewOutlet.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}

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
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = self.locationToBePLotted.titleOfPlaque;
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = self.locationToBePLotted.brochureDescription;
    }
    else if (indexPath.row == 2) {
        
        DTAPlaqueImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picture"forIndexPath:indexPath];
        
        cell.plaqueImageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.plaqueImageView.image = self.locationToBePLotted.image;

    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2)
    {
        return 250;
    }
    return 44;
}
-(void)plotLocationsOnMap:(Location *)locationToBePlotted
{
    MKPointAnnotation *pointToAnnotate = [[MKPointAnnotation alloc]init];
    
    CGFloat latitudeFloat = [locationToBePlotted.latitude floatValue];
    CGFloat longitudeFloat = [locationToBePlotted.longitude floatValue];
    
    pointToAnnotate.coordinate = CLLocationCoordinate2DMake(latitudeFloat, longitudeFloat);
    pointToAnnotate.title = locationToBePlotted.idNumber;
    
    [self.mapOutlet addAnnotation:pointToAnnotate];
}

#pragma mark - Overlap

//Content inset so that the tableview starts below the map
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableViewOutlet.contentInset = UIEdgeInsetsMake(self.tableViewOutlet.frame.size.height-40, 0, 0, 0);
}

//checks for it going below the map, hides white space
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
