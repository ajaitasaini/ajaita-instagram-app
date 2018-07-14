//
//  DetailsViewController.m
//  ajaita-instagram-app
//
//  Created by Ajaita Saini on 7/10/18.
//  Copyright © 2018 Ajaita Saini. All rights reserved.
//

#import "DetailsViewController.h"
#import <ParseUI/ParseUI.h>

@interface DetailsViewController ()

@end

@implementation DetailsViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImage];
}

#pragma mark - Image
- (void)loadImage {
    self.detailImage.file = self.post.image;
    [self.detailImage loadInBackground];
}

#pragma mark - Action
- (IBAction)onTapBackButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
