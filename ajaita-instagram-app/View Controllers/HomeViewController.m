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

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *postsTableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postsTableView.rowHeight = 600;
    self.postsTableView.delegate = self;
    self.postsTableView.dataSource = self;
    [self constructQuery];
    
    
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
            self.posts = posts;
            [self.postsTableView reloadData];
            // reload
        }
        else {
            // handle error
        }
    }];
    
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    PostTableViewCell *tappedCell = sender;
//    DetailsViewController *detailViewController = [segue destinationViewController];
//    detailViewController.currentCell = tappedCell;
//    //detailViewController.passedInImage = tappedCell.postImage;
//
    
     PostTableViewCell *tappedCell = sender;
     NSIndexPath *indexPath = [self.postsTableView indexPathForCell:tappedCell];
     Post *post = self.posts[indexPath.row];
     DetailsViewController *detailViewController = [segue destinationViewController];
     detailViewController.post = post;
}

//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    <#code#>
//}
//
//- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    <#code#>
//}


@end
