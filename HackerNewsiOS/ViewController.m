//
//  ViewController.m
//  HackerNewsiOS
//
//  Created by kiki on 10/18/15.
//  Copyright © 2015 kiki. All rights reserved.
//

#import "ViewController.h"
#import "NewsTableviewCell.h"
#import "NewsWebViewController.h"

#import <Firebase/Firebase.h>
#import <SafariServices/SafariServices.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate>
@property (nonatomic, copy) NSArray *HNStories;
@property (nonatomic, assign) NSInteger HNStoresCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // Get a reference to our posts
    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://hacker-news.firebaseio.com/v0/topstories"];
    __block NSInteger count = 0;
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        count++;
        NSLog(@"added -> %@", snapshot.value);
    }];
    // snapshot.childrenCount will always equal count since snapshot.value will include every FEventTypeChildAdded event
    // triggered before this point.
    [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"initial data loaded! %d", count == snapshot.childrenCount);
        self.HNStoresCount =snapshot.childrenCount;
        
        NSArray *smallArray = [snapshot.value subarrayWithRange:NSMakeRange(0, 10)];
        [self requestTitle: smallArray];
    }];
}

- (void)requestTitle:(NSArray *)storyIds {
    __block NSInteger count = 0;
    
    NSMutableArray *stories = [[NSMutableArray alloc] init];
    
    for (NSNumber *storyID in storyIds) {
        
        NSString *storyUrl = [NSString stringWithFormat:@"https://hacker-news.firebaseio.com/v0/item/%@", storyID];
        
        Firebase *ref = [[Firebase alloc] initWithUrl: storyUrl];
        
        [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            count++;
            
            [stories addObject:snapshot.value];

            if (count == storyIds.count) {
                self.HNStories = [stories copy];
                [self.tableView reloadData];
            }
        }];
    }
}

#pragma mark - UITableview delegate and datasource methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.HNStories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableviewCell *storeCell = [tableView dequeueReusableCellWithIdentifier:@"storeCell"];
    
    if (self.HNStories.count > 0) {
        storeCell.newsTitleLabel.text = [NSString stringWithFormat:@"%@", self.HNStories[indexPath.row][@"title"]];
    }
    
    return storeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = self.HNStories[indexPath.row][@"url"];
    SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url] entersReaderIfAvailable:YES] ;
    vc.delegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - SFSafariViewController delegate methods

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
