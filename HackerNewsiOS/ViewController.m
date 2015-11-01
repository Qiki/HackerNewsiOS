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
    
    NSString *time;
    NSString *author;
    
    if (self.HNStories.count > 0) {
        storeCell.newsTitleLabel.text = [NSString stringWithFormat:@"%@", self.HNStories[indexPath.row][@"title"] ? : @""];
    }
    
    if (self.HNStories[indexPath.row][@"time"]) {
        NSTimeInterval timeInterval = [self.HNStories[indexPath.row][@"time"] doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSTimeInterval currentTimeInterval = [[NSDate date] timeIntervalSinceDate:date
                                              ];
        time = [self convertReadableTime:currentTimeInterval];
    }
    
    if ([self.HNStories[indexPath.row][@"by"] length] > 0) {
        author = [NSString stringWithFormat:@"by %@", self.HNStories[indexPath.row][@"by"]];
    }
    
    storeCell.informationLabel.text = [NSString stringWithFormat:@"%@ %@", author, time];

    return storeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = self.HNStories[indexPath.row][@"url"];
    NewsWebViewController *vc = [[NewsWebViewController alloc] initWithURL:[NSURL URLWithString:url] entersReaderIfAvailable:YES];

    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Methods

- (NSString *)convertReadableTime:(NSTimeInterval)timeInterval {
    NSString *readableTime;
    NSInteger time = (NSInteger)timeInterval;
    NSInteger seconds = time % 60;
    NSInteger minutes = (time / 60) % 60;
    NSInteger hours = (time / 3600);
    
    if (hours > 0) {
        if (hours > 24) {
            if ((hours / 24) > 1) {
                readableTime = [NSString stringWithFormat:@"%li days ago", (long)(hours / 24)];
            } else {
                readableTime = [NSString stringWithFormat:@"%li day ago", (long)(hours / 24)];
            }
        } else {
            if (hours == 1) {
                readableTime = [NSString stringWithFormat:@"%li hr ago", (long)hours];
            } else {
                readableTime = [NSString stringWithFormat:@"%li hrs ago", (long)hours];

            }
        }
    } else if (minutes > 0) {
        readableTime = [NSString stringWithFormat:@"%li mins ago", (long)minutes];
    } else if (seconds > 0) {
        readableTime = [NSString stringWithFormat:@"%li secs ago", (long)seconds];
    }

    return readableTime;
}

@end
