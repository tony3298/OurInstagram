//
//  SearchResultsViewController.m
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/9/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "SearchResultsViewController.h"
#import <Parse/Parse.h>

@interface SearchResultsViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSArray *searchResults;

@property (weak, nonatomic) IBOutlet UISegmentedControl *peopleOrHashtags;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

-(void)setSearchResults:(NSArray *)searchResults {

    _searchResults = searchResults;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.searchResults.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];

    cell.textLabel.text = self.searchResults[indexPath.row];

    return cell;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    if (![searchController.searchBar.text isEqualToString:@""]) {

        NSLog(@"%@", searchController.searchBar.text);

        if (self.peopleOrHashtags.selectedSegmentIndex == 0) {
            PFQuery *searchQuery = [PFUser query];
            [searchQuery whereKey:@"username" containsString:searchController.searchBar.text];
//            [searchQuery whereKey:@"username" equalTo:@"Tdakhoul"];

            [searchQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {

                if (!error) {

                    NSLog(@"query result count: %lu", (unsigned long)users.count);
                    NSMutableArray *usernames = [[NSMutableArray alloc] init];

                    for (PFUser *user in users) {
//                        [user fetchIfNeeded];
                        [usernames addObject:user.username];

                        [self.tableView reloadData];
                    }
                    
                    self.searchResults = usernames;
                }

            }];

        }
    } else {

        self.searchResults = nil;
    }
}



@end
