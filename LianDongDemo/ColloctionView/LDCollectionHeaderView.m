//
//  LDCollectionReusableView.m
//  LianDongDemo
//
//  Created by WYRoy on 16/9/1.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "LDCollectionHeaderView.h"
#import "UIView+Extension.h"
#import "CategoryModel.h"
@interface LDCollectionHeaderView()
@property(nonatomic,weak)UILabel *nameLab;
@end

@implementation LDCollectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        UILabel *nameLab = [[UILabel alloc] init];
        nameLab.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];
        [self addSubview:nameLab];
        self.nameLab = nameLab;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nameLab.frame = CGRectMake(0, 0, self.Width,30);
}

- (void)setCate:(CategoryModel *)cate
{
    self.nameLab.text = cate.name;
}
@end
