//
//  ProfileViewController.m
//  ajaita-instagram-app
//
//  Created by Ajaita Saini on 7/12/18.
//  Copyright © 2018 Ajaita Saini. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "Post.h"
#import "PostCollectionViewCell.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *postsCollectionView;

@end

@implementation ProfileViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.postsCollectionView.delegate = self;
    self.postsCollectionView.dataSource = self;
    PFUser *user = [PFUser currentUser];
    
    self.profileImage.file = user[@"profileImage"];
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    self.profileImage.clipsToBounds = YES;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.postsCollectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    CGFloat imagesInEachLine = 3;
    CGFloat imageWidth = (self.postsCollectionView.frame.size.width - layout.minimumInteritemSpacing * (imagesInEachLine -1)) / imagesInEachLine;
    CGFloat imageHeight = imageWidth;
    layout.itemSize = CGSizeMake(imageWidth, imageHeight);
    
    [self constructQuery];
}

#pragma mark - Querying data

- (void) constructQuery {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    postQuery.limit = 20;
    
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.posts = [[NSMutableArray alloc] initWithArray:posts];
            [self.postsCollectionView reloadData];
            // reload
            NSLog(@"refreshed");
        }
        else {
            // handle error
        }
    }];
    
}

#pragma mark - Action

- (IBAction)onTapSetProfilePic:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            NSLog(@"Entered camera");
        }
        else {
            NSLog(@"Camera 🚫 available so we will use photo library instead");
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
}

#pragma mark - Image

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.profileImage.image = editedImage;
    
    PFUser *user = PFUser.currentUser;
    user[@"profileImage"] = [Post getPFFileFromImage:editedImage];
    NSLog(@"%@", user[@"profileImage"]);
    [user saveInBackground];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Collection View

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"postCollectionCell" forIndexPath:indexPath];
    
    [cell setupCell:self.posts[indexPath.item]];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

@end
