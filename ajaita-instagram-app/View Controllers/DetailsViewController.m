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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImage];
    // Do any additional setup after loading the view.
}

- (void)loadImage {
    self.detailImage.file = self.post.image;
    [self.detailImage loadInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
