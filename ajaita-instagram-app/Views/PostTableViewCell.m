//
//  PostTableViewCell.m
//  ajaita-instagram-app
//
//  Created by Ajaita Saini on 7/10/18.
//  Copyright © 2018 Ajaita Saini. All rights reserved.
//

#import "PostTableViewCell.h"
#import "Post.h"
#import <ParseUI/ParseUI.h>

@implementation PostTableViewCell

-(void) setupCell:(Post *)postPassed {
    self.postImage.file = postPassed.image;
    [self.postImage loadInBackground];
    self.currentPost = postPassed;
    self.postComment.text = postPassed.caption;
    self.userName.text = PFUser.currentUser.username;
    [self.likeCount setTitle:[NSString stringWithFormat:@"%@", postPassed.likeCount.stringValue] forState: UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)onTapFavorite:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query getObjectInBackgroundWithId:self.currentPost.objectId block:^(PFObject *postLikes, NSError *error) {
        [postLikes incrementKey:@"likeCount"];
        [postLikes saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Updated likes!");
                [self.likeCount setTitle:[NSString stringWithFormat:@"%@", postLikes[@"likeCount"]] forState: UIControlStateNormal];
            } else {
                NSLog(@"Didn't update likes!");
            }
        }];
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
