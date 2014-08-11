//
//  DTAAppLinkViewController.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/11/14.
//
//

#import "DTAAppLinkViewController.h"

@interface DTAAppLinkViewController ()

@end

@implementation DTAAppLinkViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
#warning needs real DTA app link
    NSURL *downtownAllianceAppURL = [NSURL URLWithString:@"linkapp://"];
    BOOL attemptToOpenSucceeded = [[UIApplication sharedApplication] openURL:downtownAllianceAppURL];

    if (!attemptToOpenSucceeded) {
        NSURL *downtownAllianceItunesURL = [NSURL URLWithString:@"https://itunes.apple.com/us/app/downtown-nyc/id458449015?mt=8"];
        [[UIApplication sharedApplication] openURL:downtownAllianceItunesURL];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"wentToDowntownAllianceApp"];    
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

@end
