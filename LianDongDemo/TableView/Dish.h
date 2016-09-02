//
//  Dish.h
//  LianDongDemo
//
//  Created by WYRoy on 16/8/31.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
// 就做一个小功能 就不写全了－－－

#import <Foundation/Foundation.h>

@interface Dish : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSNumber *min_price;
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,copy)NSString *month_saled_content;
@property(nonatomic,copy)NSString *praise_content;

@end
