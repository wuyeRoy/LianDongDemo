//
//  LDCollectionViewCell.m
//  LianDongDemo
//
//  Created by WYRoy on 16/9/1.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "LDCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "SubCategoryModel.h"
@interface LDCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *picView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@end
@implementation LDCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSubCate:(SubCategoryModel *)subCate
{
    _subCate = subCate;
    [self.picView sd_setImageWithURL:[NSURL URLWithString:subCate.icon_url]];
    self.nameLab.text = subCate.name;
}
@end
