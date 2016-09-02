//
//  RightTableViewTextCell.m
//  LianDongDemo
//
//  Created by WYRoy on 16/8/31.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "RightTableViewTextCell.h"
#import "Dish.h"
#import "UIImageView+WebCache.h"
@interface RightTableViewTextCell()
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *monthLab;

@end
@implementation RightTableViewTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"RightCELL";
    RightTableViewTextCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RightTableViewTextCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)setDish:(Dish *)dish
{
    _dish = dish;
    [self.picView sd_setImageWithURL:[NSURL URLWithString:dish.picture]];
    self.nameLab.text = dish.name;
    self.priceLab.text = [NSString stringWithFormat:@"%@",dish.min_price];
    self.monthLab.text = dish.month_saled_content;
}
@end
