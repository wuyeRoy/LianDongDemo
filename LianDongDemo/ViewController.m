//
//  ViewController.m
//  LianDongDemo
//
//  Created by WYRoy on 16/8/30.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "ViewController.h"
#import "LDTableViewController.h"
#import "LDCollectionViewController.h"
@interface ViewController ()

@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联动Demo";
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        LDTableViewController *vc = [[LDTableViewController alloc] init];
        vc.title = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        LDCollectionViewController *vc = [[LDCollectionViewController alloc] init];
        vc.title = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - setter and getter
- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = @[@"UITableView",@"UIColloction"];
    }
    return _dataArr;
}
@end
