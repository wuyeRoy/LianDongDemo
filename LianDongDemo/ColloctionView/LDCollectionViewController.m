//
//  LDCollectionViewController.m
//  LianDongDemo
//
//  Created by WYRoy on 16/8/30.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "LDCollectionViewController.h"
#import "CategoryModel.h"
#import "SubCategoryModel.h"
#import "MJExtension.h"
#import "UIView+Extension.h"
#import "LDCollectionViewCell.h"
#import "LDCollectionHeaderView.h"
#import "LJCollectionViewFlowLayout.h"
@interface LDCollectionViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,assign)BOOL isScrollDown;

@end


@implementation LDCollectionViewController

static NSString * const cellReuseIdentifier = @"LDCollectionViewCell";
static NSString * const headReuseIdentifier = @"LDCollectionHeaderView";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBody];
}

#pragma mark - setUp
- (void)setUpBody
{
    CGFloat leftX = 0;
    CGFloat leftY = 64;
    CGFloat leftW = self.view.Width / 4.0;
    CGFloat leftH = self.view.Height - leftY;
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(leftX, leftY, leftW, leftH) style:UITableViewStylePlain];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    [self.view addSubview:leftTableView];
    self.tableView = leftTableView;
    
    
    CGFloat rightX = leftW;
    CGFloat rightY = 64;
    CGFloat rightW = self.view.Width - leftW;
    CGFloat rightH = self.view.Height - rightY;
    //布局
    LJCollectionViewFlowLayout *flowLayout = [[LJCollectionViewFlowLayout alloc] init];
    //设置滚动的方向
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置item的大小
    [flowLayout setItemSize:CGSizeMake(rightW / 3.0 - 8, rightW / 3.0 - 8 + 20)];
    //设置行间距
    [flowLayout setMinimumLineSpacing:2];
    //设置列间距
    [flowLayout setMinimumInteritemSpacing:2];
    //这是头部的高度
    [flowLayout setHeaderReferenceSize:CGSizeMake(rightW, 30)];
    
    //头部悬停 ［ios9.0之后 出现的新属性］
//    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(rightX, rightY, rightW, rightH) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //通过xib 注册cell
    UINib *nib = [UINib nibWithNibName:@"LDCollectionViewCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:cellReuseIdentifier];
    
    //注册分区头标题
    [collectionView registerClass:[LDCollectionHeaderView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:headReuseIdentifier];

    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

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
    CategoryModel *cate = self.dataArr[indexPath.row];
    cell.textLabel.text = cate.name;
    cell.textLabel.font = [UIFont systemFontOfSize:11.0f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:indexPath.row];
    [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.dataArr.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    CategoryModel *cate = self.dataArr[section];
    return cate.subcategories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    CategoryModel *cate = self.dataArr[indexPath.section];
    cell.subCate = cate.subcategories[indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    LDCollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                        withReuseIdentifier:headReuseIdentifier
                                                                               forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        CategoryModel *cate = self.dataArr[indexPath.section];
        view.cate = cate;
    }
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(nonnull UICollectionReusableView *)view forElementKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (collectionView.dragging && !_isScrollDown) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (collectionView.dragging && _isScrollDown) {
        
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section + 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat offSetY = 0;
    
    UICollectionView *collectionV = (UICollectionView *)scrollView;
    if (collectionV.dragging) {
        _isScrollDown = offSetY < scrollView.contentOffset.y;
        offSetY = scrollView.contentOffset.y;
    }
}

#pragma mark - setter and getter
- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        //将json结构转成字典
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"liwushuo.json" ofType:nil]];
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *foods = dataDict[@"data"][@"categories"];
        _dataArr = [CategoryModel mj_objectArrayWithKeyValuesArray:foods];
    }
    return _dataArr;
}
@end
