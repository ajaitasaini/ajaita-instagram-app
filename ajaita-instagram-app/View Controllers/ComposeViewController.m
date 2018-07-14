//
//  ComposeViewController.m
//  ajaita-instagram-app
//
//  Created by Ajaita Saini on 7/10/18.
//  Copyright © 2018 Ajaita Saini. All rights reserved.
//

#import "ComposeViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "HomeViewController.h"
#import "MBProgressHUD.h"


@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ComposeViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSLog(@"Entered camera");
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


#pragma mark - Action

- (IBAction)onTapPost:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [Post postUserImage:self.previewImage.image withCaption:self.userCaption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error){
        [MBProgressHUD hideHUDForView:self.view animated:true];
        NSLog(@"hello it is posting good job");
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

#pragma mark - Image

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.previewImage.image = editedImage;
    
    //saves user profile picture
    PFObject *post = [[PFObject alloc] initWithClassName:@"Post"];
    post[@"postID"] = @"PostID";
    post[@"userID"] = @"userID";
    PFFile *imageFile = [PFFile fileWithName:@"photo.png" data:UIImagePNGRepresentation(editedImage)]; //editedImage is UIImage *
    post[@"image"] = imageFile;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
