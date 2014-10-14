//
//  DTAViewController.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "DTAMapViewController.h"
#import "DTADataStore.h"
#import "DTADetailViewController.h"
#import "DTAMapAnnotation.h"

@interface DTAMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapOutlet;

@end

@implementation DTAMapViewController

- (void)viewWillAppear:(BOOL)animated {
    [self setUpLocationTracking];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapOutlet.delegate = self;
    
    [self setUpDefaultViewAndPoints];
}

- (void)setUpLocationTracking {
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        [self.locationManager requestWhenInUseAuthorization];
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.locationManager.distanceFilter = 50.0f;
        
        [self.locationManager startMonitoringSignificantLocationChanges];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"%@", [locations.lastObject description]);
}

- (void)setUpDefaultViewAndPoints
{
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.mapOutlet showsUserLocation];
    
    DTADataStore *store = [DTADataStore sharedDataStore];
    self.arrayOfLocations = [store fetchDataForEntityName:@"Location"];
    
    [self plotArrayOfLocationsOnMap:self.arrayOfLocations];
    
    CGFloat latitudeFloat = 40.7089005;
    CGFloat longitudeFloat = -74.0105972;
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitudeFloat, longitudeFloat);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250.0, 250.0);
    
    [self.mapOutlet setRegion:[self.mapOutlet regionThatFits:region] animated:YES];
}

-(void)plotArrayOfLocationsOnMap:(NSArray *)arrayOfLocations
{
    for (Location *location in arrayOfLocations)
    {
        [self plotLocationsOnMap:location];
    }
}

-(void)plotLocationsOnMap:(Location *)locationToBePlotted
{
    CGFloat latitudeFloat = [locationToBePlotted.latitude floatValue];
    CGFloat longitudeFloat = [locationToBePlotted.longitude floatValue];
    
    DTAMapAnnotation *pointToAnnotate = [[DTAMapAnnotation alloc]initWithLocation:CLLocationCoordinate2DMake(latitudeFloat, longitudeFloat)];
    
    pointToAnnotate.coordinate = CLLocationCoordinate2DMake(latitudeFloat, longitudeFloat);
    pointToAnnotate.title = locationToBePlotted.titleOfPlaque;
    pointToAnnotate.location = locationToBePlotted;
    
    [self.mapOutlet addAnnotation:pointToAnnotate];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
//    if (NSClassFromString(@"MKUserLocation") == [annotation class]) {
//        return nil;
//    }
//    
//    if (annotation == mapView.userLocation) {
//        return nil;
//    }

    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"detailController" sender:view];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailController"])
    {
        MKAnnotationView *view = sender;
        DTAMapAnnotation *annotation = view.annotation;
        ((DTADetailViewController *)segue.destinationViewController).locationToBePlotted = annotation.location;
    }
}

@end
