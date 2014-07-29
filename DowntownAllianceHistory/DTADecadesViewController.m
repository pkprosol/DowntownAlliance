//
//  DTADecadesViewController.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import "DTADecadesViewController.h"

@interface DTADecadesViewController ()

- (IBAction)pre1920sTapped:(id)sender;
- (IBAction)nineteenTwentiesTapped:(id)sender;
- (IBAction)nineteenThirtiesTapped:(id)sender;
- (IBAction)nineteenFortiesTapped:(id)sender;
- (IBAction)nineteenFiftiesTapped:(id)sender;
- (IBAction)nineteenSixtiesTapped:(id)sender;
- (IBAction)nineteenSeventiesTapped:(id)sender;
- (IBAction)nineteenEightiesTapped:(id)sender;
- (IBAction)nineteenNinetiesTapped:(id)sender;
- (IBAction)twoThousandsToPresentTapped:(id)sender;

@end

@implementation DTADecadesViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)pre1920sTapped:(id)sender {
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

- (IBAction)nineteenTwentiesTapped:(id)sender {
    [self performSegueWithIdentifier:@"detailSegue" sender:self];

}

- (IBAction)nineteenThirtiesTapped:(id)sender {
}

- (IBAction)nineteenFortiesTapped:(id)sender {
}

- (IBAction)nineteenFiftiesTapped:(id)sender {
}

- (IBAction)nineteenSixtiesTapped:(id)sender {
}

- (IBAction)nineteenSeventiesTapped:(id)sender {
}

- (IBAction)nineteenEightiesTapped:(id)sender {
}

- (IBAction)nineteenNinetiesTapped:(id)sender {
}

- (IBAction)twoThousandsToPresentTapped:(id)sender {
}

@end
