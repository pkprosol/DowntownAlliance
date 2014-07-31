//
//  DTAViewController.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "DTAMainMapViewController.h"
#import "DTADataStore.h"

@interface DTAMainMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapOutlet;

@end

@implementation DTAMainMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapOutlet.delegate = self;
    
    DTADataStore *store = [DTADataStore sharedDataStore];
    
    self.arrayOfLocations = [store fetchData];
    
    [self plotArrayOfLocationsOnMap:self.arrayOfLocations];
    
    
    
    CGFloat latitudeFloat = 40.7089005;
    CGFloat longitudeFloat = -74.0105972;
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitudeFloat, longitudeFloat);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250.0, 250.0);
    
//    [self.mapOutlet setCenterCoordinate:self.mapOutlet.userLocation.location.coordinate animated:YES];
    
    
    [self.mapOutlet setRegion:[self.mapOutlet regionThatFits:region] animated:YES];
  
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


-(void)plotArrayOfLocationsOnMap:(NSArray *)arrayOfLocations
{
    for (Location *location in arrayOfLocations)
    {
        [self plotLocationsOnMap:location];
    }
}

@end
