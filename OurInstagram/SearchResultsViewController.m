//
//  SearchResultsViewController.m
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/9/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "SearchResultsViewController.h"

@interface SearchResultsViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];

    return cell;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    NSLog(@"TEST");

    NSLog(@"%d", searchController.active);

    NSLog(@"%@", searchController.searchBar.text);



}



@end
