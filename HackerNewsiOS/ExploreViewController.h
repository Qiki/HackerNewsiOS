//
//  ExploreViewController.h
//  HackerNewsiOS
//
//  Created by kiki on 10/25/15.
//  Copyright © 2015 kiki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExploreViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
