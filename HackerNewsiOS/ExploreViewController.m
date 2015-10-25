//
//  ExploreViewController.m
//  HackerNewsiOS
//
//  Created by kiki on 10/25/15.
//  Copyright © 2015 kiki. All rights reserved.
//

#import "ExploreViewController.h"

#import "ExploreCollectionviewCell.h"

@interface ExploreViewController ()

@end

@implementation ExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExploreCollectionviewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExploreCell" forIndexPath:indexPath];
    
    switch (indexPath.item) {
        case 0:
            collectionViewCell.titleLabel.text = @"New";
            
            break;
        case 1:
            collectionViewCell.titleLabel.text = @"Show";
            
            break;
            
        case 2:
            collectionViewCell.titleLabel.text = @"Jobs";
            
            break;
            
        default:
            collectionViewCell.titleLabel.text = @"Ask";
            
            break;
    }
    
    return collectionViewCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ExploreCollectionviewCell *collectionViewCell = (ExploreCollectionviewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIViewAnimationOptions flipAnimation = UIViewAnimationOptionTransitionFlipFromRight;
    
    [UIView transitionWithView:collectionViewCell
                      duration:0.3
                       options:(UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|flipAnimation)
                    animations:^{
                        
                    }
                    completion:^(BOOL finished) {
                        if (finished) {
                            
                        }
                    }];
}

@end
