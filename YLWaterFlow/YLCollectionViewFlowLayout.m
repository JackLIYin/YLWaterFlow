//
//  YLCollectionViewFlowLayout.m
//  YLWaterFlow
//
//  Created by LeonYing on 15/8/1.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YLCollectionViewFlowLayout.h"


@interface YLCollectionViewFlowLayout ()

// 自定义的主要目的，是自定义每一个cell的frame，这个数组就是存这种数据的
@property (nonatomic, strong) NSArray *attris;
@end

@implementation YLCollectionViewFlowLayout

#warning 步骤 ④ ：重写两个重要的方法（主要是计算每个cell的frame）

// 这个方法用于初始化
- (void)prepareLayout {
    
    // 这里主要是创建了一个用来保存每个cell的frame属性的数组
    // 每个元素的 frame 在瀑布流中是要单独算出来的，这样为什么不直接scrollView省事呢？因为collectionView有重用单元格等优势
    // 注：在实际使用中，每个元素的frame是要作为模型传过来的，这里简单的计算出frame，只是为了演示效果

    NSMutableArray *marr = [NSMutableArray array];
    
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 30) / 2;

    for (int i = 0; i < 30; i++) {
        UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath: [NSIndexPath indexPathForItem:i inSection:0]];
        
        CGFloat h;
        CGFloat x;
        CGFloat y;
        
        
        // 每个cell的frame 是分别计算出来的，这里需要取得他上面的cell的frame
        if (i == 0 ) {
            x = 10;
            y = 10;
        } else if (i == 1) {
            x = w + 10 * 2;
            y = 10;
        } else if (i % 2 == 0) {
            UICollectionViewLayoutAttributes *lastAttri = marr[i - 2];
            x = 10;
            y = CGRectGetMaxY(lastAttri.frame) + 10;
        } else {
            UICollectionViewLayoutAttributes *lastAttri = marr[i - 2];
            x = w + 10 * 2;
            y = CGRectGetMaxY(lastAttri.frame) + 10;
        }
        
        // 这个高度是随便设置的，也就是每隔几个，有一个固定高度的cell用来显示时间
        h = 150 + arc4random_uniform(100);
        if (i % 5 == 0) {
            h = 30;
        }
        
        attri.frame = CGRectMake(x, y, w, h);
        
        [marr addObject:attri];
        
    }
    
    UICollectionViewLayoutAttributes *attr1 = marr[29];
    UICollectionViewLayoutAttributes *attr2 = marr[28];
    CGFloat h = CGRectGetMaxY(attr1.frame) + CGRectGetMaxY(attr2.frame);
    
    
#warning 步骤 ⑤ ：这里一定要设置itemSize为平均的大小

    // 这个参数主要是设置滚动的尺寸的（不设置，是无法滚动的），这里计算出平均值，相当于使每个单元格一样大（算的不准，有待优化）
    self.itemSize = CGSizeMake(w, h / 30);
    
    self.attris = marr.copy;
    
}

// 返回 每个 cell 的frame数据
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attris;
}


@end
