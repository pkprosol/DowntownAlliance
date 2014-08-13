//
//  DTAAppLinkViewController.m
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 8/11/14.
//
//

#import "DTAAppLinkViewController.h"

@interface DTAAppLinkViewController ()

- (void)goToAppStoreOrDowntownAllianceApp;

@end

@implementation DTAAppLinkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self goToAppStoreOrDowntownAllianceApp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)goToAppStoreOrDowntownAllianceApp
{
    NSURL *downtownAllianceAppURL = [NSURL URLWithString:@"fb136677513090884://"];
    BOOL attemptToOpenSucceeded = [[UIApplication sharedApplication] openURL:downtownAllianceAppURL];
    
    if (!attemptToOpenSucceeded) {
        NSURL *downtownAllianceItunesURL = [NSURL URLWithString:@"https://itunes.apple.com/us/app/downtown-nyc/id458449015?mt=8"];
        [[UIApplication sharedApplication] openURL:downtownAllianceItunesURL];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"wentToDowntownAllianceApp"];
}


@end
