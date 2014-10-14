//
//  DTAAppDelegate.h
//  DowntownAllianceHistory
//
//  Created by Piotr K Prosol on 7/29/14.
//
//

#import <UIKit/UIKit.h>
#import "DTAUserLocationManagement.h"
@interface DTAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabbar;
@property (strong, nonatomic) DTAUserLocationManagement *geoFence;

-(void)setUpFromGeoFence;

@end
