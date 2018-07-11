//
//  PostTableViewCell.m
//  ajaita-instagram-app
//
//  Created by Ajaita Saini on 7/10/18.
//  Copyright © 2018 Ajaita Saini. All rights reserved.
//

#import "PostTableViewCell.h"
#import "Post.h"

@implementation PostTableViewCell

-(void) setupCell:(Post *)postPassed {
    self.postImage.file = postPassed.image;
    [self.postImage loadInBackground];
    self.currentPost = postPassed;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
