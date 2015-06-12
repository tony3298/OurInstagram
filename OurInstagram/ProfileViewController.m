//
//  ProfileViewController.m
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/9/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserPostCollectionViewCell.h"
#import "Post.h"
#import <Parse/Parse.h>

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIAlertViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *postsCollectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsBarButton;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberFollowingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;


@property PFUser *currentUser;

@property NSArray *userPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.settingsBarButton.title = @"\u2699";
    UIFont *f1 = [UIFont fontWithName:@"Helvetica" size:24.0];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:f1, NSFontAttributeName, nil];
    [self.settingsBarButton setTitleTextAttributes:dict forState:UIControlStateNormal];

    self.currentUser = [PFUser currentUser];
    [self updateUserProfileInfo];
}

- (void) updateUserProfileInfo {

    self.usernameLabel.text = self.currentUser.username;
}

-(void)viewDidAppear:(BOOL)animated {
    [self updateUserProfileInfo];

    [self fetchUserPosts];
    [self fetchUserProfileImage];
}

-(void)fetchUserProfileImage {

    if ([PFUser currentUser]) {


        PFUser *user = [PFUser currentUser];

        PFFile *profileImageFile = [user objectForKey:@"profileImage"];

        if (profileImageFile) {

            [profileImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {

                if (!error) {

                    NSLog(@"NO error");

                    UIImage *image = [UIImage imageWithData:data];

                    [self setProfileImageViewImage:image];
                }
            }];
        }
    }
}

-(void)fetchUserPosts {

    if ([PFUser currentUser]) {
        PFQuery *userPostsQuery = [PFQuery queryWithClassName:@"Post"];
        [userPostsQuery orderByDescending:@"createdAt"];
        //        [userPostsQuery whereKey:@"user" equalTo:[PFUser currentUser]];
        [userPostsQuery findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {

            if (!error) {
                NSLog(@"Successfully retrieved %lu posts.", posts.count);

                NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];

                for (PFObject *postObject in posts) {

                    Post *post = [[Post alloc] initWithPostObject:postObject];

                    if (post.imagePFFile) {

                        [post.imagePFFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {

                            if (!error) {
                                UIImage *image = [UIImage imageWithData:data];
                                post.image = image;

                                [self.postsCollectionView reloadData];
                            }
                        }];
                                            }
                    
                    [mutablePosts addObject:post];
                }
                
                self.userPosts = mutablePosts;
                self.numberOfPostsLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.userPosts.count];
                //                NSLog(@"Tableview reloaded.");
                //                [self.tableView reloadData];
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userPosts.count;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(0, 0, 0, 0.5); // top, left, bottom, right

}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {

    return 0.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    return 0.0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(self.view.frame.size.width/3 - 3, self.view.frame.size.width/3 - 3);

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UserPostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];

//    cell.frame.size = CGSizeMake(self.view.frame.size.width/3 - 3, self.view.frame.size.width/3 - 3);

    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;

    Post *post = self.userPosts[indexPath.row];

    cell.imageView.image = post.image;

    return cell;
}

- (IBAction)onLogoutTapped:(UIBarButtonItem *)sender {

    if ([PFUser currentUser]) {

        NSLog(@"Logging out");

        [PFUser logOut];

//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//        LoginViewController *loginVC = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
//        [self presentViewController:loginVC animated:YES completion:nil];

        self.tabBarController.selectedIndex = 0;
    }
}

- (IBAction)onAddProfilePicTapped:(UIButton *)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Profile Picture" message:@"Do you want to take a picture or upload a picture?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Upload", @"Take Picture", nil];

    [alert show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 1) {
        NSLog(@"Upload tapped");

        [self uploadFromPhotoAlbum];
    } else if (buttonIndex == 2) {

        [self uploadFromCamera];
    }

}

-(void)uploadFromPhotoAlbum {

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;

    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePicker animated:YES completion:nil];

}

-(void)uploadFromCamera {

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;

    imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;

    [self presentViewController:imagePicker animated:YES completion:nil];

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    // save photo
//    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];


    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    if (image) {

        NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
        PFFile *imageFile = [PFFile fileWithName:@"profileimage.jpeg" data:imageData];
        [imageFile saveInBackground];

        //                PFUser *user = [PFUser currentUser];
        //                [user setObject:imageFile forKey:@"profilePic"];
        //                [user saveInBackground];

        PFUser *user = [PFUser currentUser];

        if (user) {

            [user setObject:imageFile forKey:@"profileImage"];

            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

                if (error) {
                    NSLog(@"%@", error);
                }
                if (succeeded) {
                    NSLog(@"succeeded");
                }
            }];
        }
        [self setProfileImageViewImage:image];

        UIImageWriteToSavedPhotosAlbum(image,nil,nil,nil);
    }

    

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setProfileImageViewImage:(UIImage *)image {

    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.layer.masksToBounds = YES;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
    self.profileImageView.image = image;
}

@end
