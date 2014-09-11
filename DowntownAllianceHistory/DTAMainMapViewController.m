//
//  DTAViewController.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "DTAMainMapViewController.h"
#import "DTADataStore.h"
#import "UITabBarController+hidableTab.h"
#import "DTADetailViewController.h"
#import "DTAMapAnnotation.h"

@interface DTAMainMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapOutlet;

@end

@implementation DTAMainMapViewController

{
    CGFloat startContentOffset;
    CGFloat lastContentOffset;
    BOOL hidden;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"SOCIAL APP!", @"");
        hidden = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapOutlet.delegate = self;
    
    DTADataStore *store = [DTADataStore sharedDataStore];
    
    self.arrayOfLocations = [store fetchDataForEntityName:@"Location"];
    
    [self plotArrayOfLocationsOnMap:self.arrayOfLocations];
    
    CGFloat latitudeFloat = 40.7089005;
    CGFloat longitudeFloat = -74.0105972;
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitudeFloat, longitudeFloat);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250.0, 250.0);
    
    [self.mapOutlet setRegion:[self.mapOutlet regionThatFits:region] animated:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:hidden
                                             animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
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
}

-(void)contract
{
    if(!hidden)
        return;
    
    hidden = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    startContentOffset = lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat differenceFromStart = startContentOffset - currentOffset;
    CGFloat differenceFromLast = lastContentOffset - currentOffset;
    lastContentOffset = currentOffset;
    
    if((differenceFromStart) < 0)
    {
        if(scrollView.isTracking && (abs(differenceFromLast)>1))
            [self expand];
    }
    else {
        if(scrollView.isTracking && (abs(differenceFromLast)>1))
            [self contract];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [self contract];
    return YES;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if (NSClassFromString(@"MKUserLocation")==[annotation class]) {
        return nil;
    }
    
    if (annotation == mapView.userLocation) {
        return nil;
    }
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"detailController" sender:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)plotLocationsOnMap:(Location *)locationToBePlotted
{
//    MKPointAnnotation *pointToAnnotate = [[MKPointAnnotation alloc]init];
    
    CGFloat latitudeFloat = [locationToBePlotted.latitude floatValue];
    CGFloat longitudeFloat = [locationToBePlotted.longitude floatValue];
    
    DTAMapAnnotation *pointToAnnotate = [[DTAMapAnnotation alloc]initWithLocation:CLLocationCoordinate2DMake(latitudeFloat, longitudeFloat)];
    
    pointToAnnotate.coordinate = CLLocationCoordinate2DMake(latitudeFloat, longitudeFloat);
    pointToAnnotate.title = locationToBePlotted.titleOfPlaque;
    pointToAnnotate.location = locationToBePlotted;
    
    [self.mapOutlet addAnnotation:pointToAnnotate];
}

-(void)plotArrayOfLocationsOnMap:(NSArray *)arrayOfLocations
{
    for (Location *location in arrayOfLocations)
    {
        [self plotLocationsOnMap:location];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailController"])
    {
    
        MKAnnotationView *view = sender;
        DTAMapAnnotation *annotation = view.annotation;
        ((DTADetailViewController *)segue.destinationViewController).locationToBePLotted = annotation.location;
    }
}

@end
