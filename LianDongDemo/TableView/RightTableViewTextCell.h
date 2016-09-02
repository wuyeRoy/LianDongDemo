//
//  RightTableViewTextCell.h
//  LianDongDemo
//
//  Created by WYRoy on 16/8/31.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Dish;
@interface RightTableViewTextCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)Dish *dish;
@end
