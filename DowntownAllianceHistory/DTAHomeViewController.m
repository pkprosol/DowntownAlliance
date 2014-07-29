//
//  DTAViewController.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "DTAHomeViewController.h"

@interface DTAHomeViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapOutlet;

@end

@implementation DTAHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.arrayOfLocations = [DTADataFetchFromCSV importCSV];
    
    [self plotArrayOfLocationsOnMap:self.arrayOfLocations];
  
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
    
    //CGFloat latitudeFloat = locationToBePlotted.latitude;
    //CGFloat longitudeFloat = locationToBePlotted.longitude;
    
    //pointToAnnotate.coordinate = CLLocationCoordinate2DMake(latitudeFloat, longitudeFloat);
    //pointToAnnotate.title = locationToBePlotted.idNumber;
    
    //[self.mapOutlet addAnnotation:pointToAnnotate];
}

-(void)plotArrayOfLocationsOnMap:(NSArray *)arrayOfLocations
{
    for (Location *location in arrayOfLocations)
    {
        [self plotLocationsOnMap:location];
    }
}

@end
