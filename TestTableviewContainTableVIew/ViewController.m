//
//  ViewController.m
//  TestTableviewContainTableVIew
//
//  Created by 钟伟杰 on 2020/2/5.
//  Copyright © 2020 钟伟杰. All rights reserved.
//

#import "ViewController.h"
#import "ContainTableViewTableViewCell.h"

static NSString *const kNormalTabelViewCell = @"kNormalTabelViewCell";
static NSString *const kContainTableViewCell = @"kContainTableViewCell";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *testArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTableView];
    
    self.testArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger count = 0; count < 20; count++) {
        [self.testArr addObject:@(count)];
    }
    
    [self.mainTableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.mainTableView.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.testArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContainTableViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kContainTableViewCell];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //模拟网络预加载数据新增上拉长度
    CGFloat tableViewContentOffsetY = scrollView.contentOffset.y;
    CGFloat cellHeight = self.mainTableView.frame.size.height;
    
    NSInteger scrollIndex = tableViewContentOffsetY / cellHeight;
    if (scrollIndex == self.testArr.count/2) {
        NSInteger maxCount = self.testArr.count;
        NSMutableArray<NSIndexPath *> *insertIndexPathCellArr = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger count = maxCount; count < maxCount + 10; count ++) {
            [self.testArr addObject:@(count)];
            NSIndexPath *insertIndexPathCell = [NSIndexPath indexPathForRow:count-1 inSection:0];
            [insertIndexPathCellArr addObject:insertIndexPathCell];
        }

        [UIView performWithoutAnimation:^{
            [self.mainTableView insertRowsAtIndexPaths:insertIndexPathCellArr withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ContainTableViewTableViewCell *containCell = (ContainTableViewTableViewCell *)cell;
    [containCell setupCell:indexPath.row];
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64) style:UITableViewStylePlain];
        _mainTableView.automaticallyAdjustsScrollIndicatorInsets = NO;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kNormalTabelViewCell];
        [_mainTableView registerClass:[ContainTableViewTableViewCell class] forCellReuseIdentifier:kContainTableViewCell];
        _mainTableView.estimatedRowHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.pagingEnabled = YES;
    }
    return _mainTableView;
}

@end
