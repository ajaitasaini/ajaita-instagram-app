//
//  ProfileViewController.h
//  ajaita-instagram-app
//
//  Created by Ajaita Saini on 7/12/18.
//  Copyright © 2018 Ajaita Saini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (strong, nonatomic) NSMutableArray *posts;
@end
