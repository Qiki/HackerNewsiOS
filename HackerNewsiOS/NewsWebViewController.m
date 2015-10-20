//
//  NewsWebViewController.m
//  HackerNewsiOS
//
//  Created by Guanxiong Ding on 10/18/15.
//  Copyright © 2015 kiki. All rights reserved.
//

#import "NewsWebViewController.h"

@interface NewsWebViewController () <UIWebViewDelegate>

@end

@implementation NewsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL ? : @""]]];
    self.webView.scalesPageToFit = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
