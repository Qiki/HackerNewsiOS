//
//  NewsWebViewController.m
//  HackerNewsiOS
//
//  Created by Guanxiong Ding on 10/18/15.
//  Copyright © 2015 kiki. All rights reserved.
//

#import "NewsWebViewController.h"

@interface NewsWebViewController () <SFSafariViewControllerDelegate>

@end

@implementation NewsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

#pragma mark - SFSafariViewController delegate methods

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [controller.navigationController popToRootViewControllerAnimated:YES];
}

- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    NSLog(@"DONE!");
}

@end
