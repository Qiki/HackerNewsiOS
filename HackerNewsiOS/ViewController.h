//
//  ViewController.h
//  HackerNewsiOS
//
//  Created by kiki on 10/18/15.
//  Copyright © 2015 kiki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;


@end

@interface ViewController (Test)

- (NSString *)convertReadableTime:(NSTimeInterval)timeInterval;

@end

