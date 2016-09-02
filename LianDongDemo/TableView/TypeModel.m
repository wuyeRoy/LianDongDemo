//
//  TypeModel.m
//  LianDongDemo
//
//  Created by WYRoy on 16/8/31.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "TypeModel.h"
#import "Dish.h"
@implementation TypeModel

+ (NSDictionary *)objectClassInArray
{
    return @{ @"spus": [Dish class]};
}

@end
