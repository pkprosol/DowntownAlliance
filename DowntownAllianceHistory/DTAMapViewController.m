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
    self.mapOutlet.delegate = self;
    [self setUpDefaultViewAndPoints];
}

- (void)setUpDefaultViewAndPoints
{
    [self setUpMapZoom];
    [self setUpMapPoints];
}

- (void)setUpMapPoints {
    DTADataStore *store = [DTADataStore sharedDataStore];
    self.arrayOfLocations = [store fetchDataForEntityName:@"Location"];
    [self plotArrayOfLocationsOnMap:self.arrayOfLocations];
}

- (void)setUpMapZoom {
    CGFloat centerOfCOHLatitude = 40.707872;
    CGFloat centerOfCOHLongitude = -74.011115;
    
    CLLocation *centerOfCOH = [[CLLocation alloc] initWithLatitude:centerOfCOHLatitude longitude:centerOfCOHLongitude];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    CLLocation *userLocation = locationManager.location;
    CLLocationDistance userDistanceFromCOH = [userLocation distanceFromLocation:centerOfCOH];

    MKCoordinateRegion regionToZoomMap;
    
    if (userLocation && userDistanceFromCOH < 1200) {
        CLLocationCoordinate2D userLocationCoordinate = userLocation.coordinate;
        CGFloat userLatitude = userLocationCoordinate.latitude;
        CGFloat userLongitude = userLocationCoordinate.longitude;
        
        CGFloat midPointBetweenUserAndCOHLatitude = (centerOfCOHLatitude + userLatitude) / 2;
        CGFloat midPointBetweenUserAndCOHLongitude = (centerOfCOHLongitude + userLongitude) / 2;
        CLLocationCoordinate2D midPointBetweenUserAndCOHCoordinate = CLLocationCoordinate2DMake(midPointBetweenUserAndCOHLatitude, midPointBetweenUserAndCOHLongitude);
        
        MKCoordinateRegion regionCenteredOnUser = MKCoordinateRegionMakeWithDistance(midPointBetweenUserAndCOHCoordinate, 1000, 1000);
        regionToZoomMap = regionCenteredOnUser;
    } else {
        CLLocationCoordinate2D centerOfCOHCoordinate = CLLocationCoordinate2DMake(centerOfCOHLatitude, centerOfCOHLongitude);
        MKCoordinateRegion regionCenteredOnCOH = MKCoordinateRegionMakeWithDistance(centerOfCOHCoordinate, 600, 600);
        regionToZoomMap = regionCenteredOnCOH;
    }
    
    [self.mapOutlet setRegion:[self.mapOutlet regionThatFits:regionToZoomMap] animated:YES];
}

- (void)plotArrayOfLocationsOnMap:(NSArray *)arrayOfLocations
{
    for (Location *location in arrayOfLocations)
    {
        [self plotLocationsOnMap:location];
    }
}

- (void)plotLocationsOnMap:(Location *)locationToBePlotted
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
    if (NSClassFromString(@"MKUserLocation") == [annotation class]) {
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
