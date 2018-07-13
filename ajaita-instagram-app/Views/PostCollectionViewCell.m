//
//  PostCollectionViewCell.m
//  ajaita-instagram-app
//
//  Created by Ajaita Saini on 7/12/18.
//  Copyright © 2018 Ajaita Saini. All rights reserved.
//

#import "PostCollectionViewCell.h"
#import <ParseUI/ParseUI.h>
#import "Post.h"

@implementation PostCollectionViewCell


-(void) setupCell:(Post *)postPassed {
    self.postImage.file = postPassed.image;
    [self.postImage loadInBackground];
    self.currentPost = postPassed;
    self.postComment.text = postPassed.caption;
}

@end
