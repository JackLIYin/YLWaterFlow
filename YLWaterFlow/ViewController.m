//
//  ViewController.m
//  YLWaterFlow
//
//  Created by LeonYing on 16/1/13.
//  Copyright (c) 2016年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "YLCollectionViewFlowLayout.h"

@interface ViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) YLCollectionViewFlowLayout *flowLayout;

@end

@implementation ViewController


#warning 步骤 ①：使用到自定义布局对象来布局每一个元素

- (YLCollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[YLCollectionViewFlowLayout alloc] init];
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.minimumLineSpacing = 10;
    }
    return _flowLayout;
}

#warning 步骤 ② ：创建collectionView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout: self.flowLayout];
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.collectionView.frame = [UIScreen mainScreen].bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


#warning 步骤 ③ ：实现代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    if (indexPath.item % 5 == 0) {
        cell.backgroundColor = [UIColor redColor];
    }
    
    return cell;
}



@end
