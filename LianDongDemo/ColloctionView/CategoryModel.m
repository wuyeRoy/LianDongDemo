//
//  CategoryModel.m
//  LianDongDemo
//
//  Created by WYRoy on 16/9/1.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "CategoryModel.h"
#import "SubCategoryModel.h"
@implementation CategoryModel
+ (NSDictionary *)objectClassInArray
{
    return @{ @"subcategories": [SubCategoryModel class]};
}
@end
