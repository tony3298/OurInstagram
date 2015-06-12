//
//  SearchViewController.m
//  OurInstagram

//  Created by Tony Dakhoul on 6/8/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultsViewController.h"

@interface SearchViewController () <UISearchControllerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property SearchResultsViewController *searchResultsViewController;
@property UISearchController *searchController;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.hidden = NO;
    self.tableView.hidden = YES;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.searchResultsViewController = [storyboard instantiateViewControllerWithIdentifier:@"SearchResultsViewController"];

    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsViewController];

    self.searchController.searchResultsUpdater = self.searchResultsViewController;
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = false;
    self.searchController.hidesNavigationBarDuringPresentation = false;
    self.navigationItem.titleView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    self.searchController.dimsBackgroundDuringPresentation = YES;
}

-(void)willPresentSearchController:(UISearchController *)searchController {

    NSLog(@"%d", self.searchController.active);

//    self.searchController.active = YES;
//    searchController.searchResultsController.view.hidden = NO;

//    dispatch_async(dispatch_get_main_queue(), ^{
//        searchController.searchResultsController.view.hidden = NO;
//    });
}

-(void)didPresentSearchController:(UISearchController *)searchController {

    NSLog(@"%d", self.searchController.active);

//    searchController.searchResultsController.view.hidden = NO;
}

-(void)presentSearchController:(UISearchController *)searchController {

    NSLog(@"Present search controller");
        dispatch_async(dispatch_get_main_queue(), ^{
            searchController.searchResultsController.view.hidden = NO;
        });
}

-(void)willDismissSearchController:(UISearchController *)searchController {

    NSLog(@"Will dismiss");
}

-(void)didDismissSearchController:(UISearchController *)searchController {

    NSLog(@"Did dismiss");
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    //Prevents searchController from disappearing
    if ([searchText isEqualToString:@""])
    {
        [self presentSearchController:self.searchController];
    }
}

//-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//
//    NSLog(@"TEST");
//    
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];

    cell.textLabel.text = @"Test";
    return cell;
}

- (IBAction)photosOrPeople:(UISegmentedControl *)sender {

    if (sender.selectedSegmentIndex == 0) {

        self.collectionView.hidden = NO;
        self.tableView.hidden = YES;
    } else {

        self.collectionView.hidden = YES;
        self.tableView.hidden = NO;
    }
}

@end
