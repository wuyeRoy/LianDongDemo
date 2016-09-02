//
//  SubCategoryModel.h
//  LianDongDemo
//
//  Created by WYRoy on 16/9/1.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubCategoryModel : NSObject
@property(nonatomic,copy)NSString *icon_url;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,strong)NSNumber *order;
@property(nonatomic,strong)NSNumber *items_count;
@property(nonatomic,strong)NSNumber *parent_id;
@property(nonatomic,strong)NSNumber *status;
@end
