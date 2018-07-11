//
//  PostTableViewCell.h
//  ajaita-instagram-app
//
//  Created by Ajaita Saini on 7/10/18.
//  Copyright © 2018 Ajaita Saini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Post.h"

@interface PostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (strong, nonatomic) Post *currentPost;
@property (weak, nonatomic) IBOutlet UILabel *postComment;

-(void) setupCell:(Post *)postPassed;

@end
