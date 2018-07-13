//
//  UpdateProfileViewController.m
//  ajaita-instagram-app
//
//  Created by Ajaita Saini on 7/13/18.
//  Copyright © 2018 Ajaita Saini. All rights reserved.
//

#import "UpdateProfileViewController.h"
#import <Parse/Parse.h>
#import "Post.h"

@interface UpdateProfileViewController ()

@end

@implementation UpdateProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    PFUser *currentUser = [PFUser currentUser];
    //currentUser.
    
    _profileImage.image = editedImage;
    
    //user
    //PFUser currentUser.editedImage = editedImage;
    
    PFObject *profile = [[PFObject alloc] initWithClassName:@"Profile"];
    //profile[@"postID"] = @"PostID";
    //profile[@"userID"] = currentUser.username;
    PFFile *imageFile = [PFFile fileWithName:@"photo.png" data:UIImagePNGRepresentation(editedImage)]; //editedImage is UIImage *
    profile[@"image"] = imageFile;
    
    
    // Do something with the images (based on your use case)
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
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
