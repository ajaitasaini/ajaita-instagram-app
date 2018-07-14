//
//  HomeViewController.m
//  ajaita-instagram-app
//
//  Created by Ajaita Saini on 7/9/18.
//  Copyright © 2018 Ajaita Saini. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "PostTableViewCell.h"
#import "DetailsViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *postsTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postsTableView.rowHeight = 600;
    self.postsTableView.delegate = self;
    self.postsTableView.dataSource = self;
    [self constructQuery];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(constructQuery) forControlEvents:UIControlEventValueChanged];
    [self.postsTableView insertSubview:self.refreshControl atIndex:0];
}

- (IBAction)onTapLogout:(id)sender {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [app logout];
    
}

- (IBAction)onTapUserProfileImage:(id)sender {
    [self performSegueWithIdentifier:@"profilePicSegue" sender: nil];
}

- (IBAction)onTapUserName:(id)sender {
    [self performSegueWithIdentifier:@"profileSegue" sender: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTapCompose:(id)sender {
    [self performSegueWithIdentifier:@"composeSegue" sender: nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableViewCell *cell = [self.postsTableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    [cell setupCell:self.posts[indexPath.row]];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"instagram_name"]];
    
    return cell;
}

- (void) constructQuery {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.posts = [[NSMutableArray alloc] initWithArray:posts];
            [self.postsTableView reloadData];
            // reload
            NSLog(@"refreshed");
            [self.refreshControl endRefreshing];
        }
        else {
            // handle error
        }
    }];
    
}

-(void)loadMoreData{
    PFQuery *nextPostQuery = [Post query];
    [nextPostQuery orderByDescending:@"createdAt"];
    [nextPostQuery includeKey:@"author"];
    nextPostQuery.limit = 20;
    nextPostQuery.skip = [self.posts count];
    
    // fetch data asynchronously
    [nextPostQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable newPosts, NSError * _Nullable error) {
        if (newPosts) {
            // do something with the data fetched
            for (Post *post in newPosts) {
                [self.posts addObject:post];
            }
            self.isMoreDataLoading = false;
            [self.postsTableView reloadData];
            // reload
            NSLog(@"refreshed");
            [self.refreshControl endRefreshing];
        }
        else {
            self.isMoreDataLoading = false;
            [self.postsTableView reloadData];
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        int scrollViewContentHeight = self.postsTableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.postsTableView.bounds.size.height;
        
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.postsTableView.isDragging) {
            self.isMoreDataLoading = true;
            [self loadMoreData];
        }
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]){
        PostTableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.postsTableView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        UINavigationController *navigationController = [segue destinationViewController];
        DetailsViewController *detailViewController = (DetailsViewController*)navigationController.topViewController;
        detailViewController.post = post;
    }
}


@end
