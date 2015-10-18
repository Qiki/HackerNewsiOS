//
//  ViewController.m
//  HackerNewsiOS
//
//  Created by kiki on 10/18/15.
//  Copyright © 2015 kiki. All rights reserved.
//

#import "ViewController.h"

#import <Firebase/Firebase.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Firebase *fireBase = [[Firebase alloc] initWithUrl:@"https://hacker-news.firebaseio.com"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
