//
//  DetailsViewController.h
//  ajaita-instagram-app
//
//  Created by Ajaita Saini on 7/10/18.
//  Copyright © 2018 Ajaita Saini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Post.h"
#import "PostTableViewCell.h"

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet PFImageView *detailImage;
@property (strong, nonatomic) PFImageView *passedInImage;
@property (weak, nonatomic) IBOutlet PostTableViewCell *currentCell;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) Post *post;
//@property (nonatomic, weak) id<DetailsViewControllerDelegate> delegate;

@end
