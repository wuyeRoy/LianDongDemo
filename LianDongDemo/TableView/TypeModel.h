//
//  TypeModel.h
//  LianDongDemo
//
//  Created by WYRoy on 16/8/31.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeModel : NSObject

@property(nonatomic,strong)NSNumber *tag;
@property(nonatomic,copy)NSString *name;
/**
 *  图片下载路径
 */
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,strong)NSNumber *current_page;
@property(nonatomic,assign)BOOL has_next_page;
@property(nonatomic,strong)NSNumber *product_count;
@property(nonatomic,strong)NSNumber *type;
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,strong)NSNumber *tag_description;
@property(nonatomic,strong)NSNumber *sequence;
@property(nonatomic,strong)NSArray *spus;
@property(nonatomic,strong)NSNumber *buzType;

@end
