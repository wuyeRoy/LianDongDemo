//
//  LDViewController.m
//  LianDongDemo
//
//  Created by WYRoy on 16/8/30.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "LDTableViewController.h"
#import "UIView+Extension.h"
#import "MJExtension.h"
#import "TypeModel.h"
#import "Dish.h"
#import "RightTableViewTextCell.h"
@interface LDTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign)BOOL isScrollDown;

@property(nonatomic,weak)UITableView *leftTabView;
@property(nonatomic,weak)UITableView *rightTabView;

@property(nonatomic,strong)NSArray *leftDataArr;

@end

@implementation LDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpBody];
}

#pragma mark - setUp
- (void)setUpBody
{
    CGFloat leftX = 0;
    CGFloat leftY = 64;
    CGFloat leftW = self.view.Width / 4.0;
    CGFloat leftH = self.view.Height - leftY;
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(leftX, leftY, leftW, leftH) style:UITableViewStyleGrouped];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    [self.view addSubview:leftTableView];
    self.leftTabView = leftTableView;
    
    
    CGFloat rightX = leftW;
    CGFloat rightY = 64;
    CGFloat rightW = self.view.Width - leftW;
    CGFloat rightH = self.view.Height - rightY;
    UITableView *rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(rightX, rightY, rightW, rightH) style:UITableViewStylePlain];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    [self.view addSubview:rightTableView];
    self.rightTabView = rightTableView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.leftTabView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.leftTabView) {
        return 1;
    }
    else
    {
        return self.leftDataArr.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTabView) {
        return self.leftDataArr.count;
    }
    else
    {
        TypeModel *type = self.leftDataArr[section];
        return type.spus.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTabView) {
        static NSString *ID = @"LeftCELL";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        TypeModel *type = self.leftDataArr[indexPath.row];
        cell.textLabel.text = type.name;
        cell.textLabel.font = [UIFont systemFontOfSize:11.0f];
        return cell;
    }
    else
    {
        RightTableViewTextCell *cell = [RightTableViewTextCell cellWithTableView:tableView];
        TypeModel *type = self.leftDataArr[indexPath.section];
        cell.dish = type.spus[indexPath.row];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.rightTabView) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.Width/4.0 * 3, 20)];
        lab.backgroundColor = [UIColor lightGrayColor];
        lab.textAlignment = NSTextAlignmentLeft;
        TypeModel *type = self.leftDataArr[section];
        lab.text = [NSString stringWithFormat:@" %@",type.name];
        return lab;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.rightTabView) {
        return 20;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTabView) {
        return 44;
    }
    else
    {
        return 70;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTabView) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        [self.rightTabView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


/**
 *   向上滚动时，获取即将出现的View
 */
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    //右边的tabView  向上滚动  拉拽
    if (tableView == self.rightTabView && !_isScrollDown && tableView.dragging) {
        
        [self.leftTabView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

/**
 *  向下滚动时，获取即将消失的View   将section＋1
 */
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (tableView == self.rightTabView && _isScrollDown && tableView.dragging) {
        [self.leftTabView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section + 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

/**
 *  判断是向上滚  还是向下滚
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    
    UITableView *tableV = (UITableView *)scrollView;
    if (tableV == self.rightTabView) {
        _isScrollDown = lastOffsetY < tableV.contentOffset.y;
        lastOffsetY = tableV.contentOffset.y;
    }
}


#pragma mark - setter and getter
- (NSArray *)leftDataArr
{
    if (_leftDataArr == nil) {
        //将json结构转成字典
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"meituan.json" ofType:nil]];
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *foods = dataDict[@"data"][@"food_spu_tags"];
        _leftDataArr = [TypeModel mj_objectArrayWithKeyValuesArray:foods];
        
    }
    return _leftDataArr;
}

@end
