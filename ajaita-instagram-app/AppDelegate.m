//
//  AppDelegate.m
//  ajaita-instagram-app
//
//  Created by Ajaita Saini on 7/9/18.
//  Copyright © 2018 Ajaita Saini. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(  NSDictionary *)launchOptions {
    
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        
        configuration.applicationId = @"instagram";
        configuration.clientKey = @"ajaita";
        configuration.server = @"http://instagram-ajaita.herokuapp.com/parse";
    }];
    
    [Parse initializeWithConfiguration:config];
    
    if (PFUser.currentUser) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeTabBarController"];
    }
    
    return YES;
}

-(void) logout{
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        NSLog(@"Logged out!");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    }];
}

@end
