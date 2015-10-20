//
//  NewsWebViewController.h
//  HackerNewsiOS
//
//  Created by Guanxiong Ding on 10/18/15.
//  Copyright © 2015 kiki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsWebViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, copy) NSString *webURL;

@end
