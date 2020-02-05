//
//  ViewController.m
//  TestTableviewContainTableVIew
//
//  Created by 钟伟杰 on 2020/2/5.
//  Copyright © 2020 钟伟杰. All rights reserved.
//

#import "ViewController.h"

static NSString *const kNormalTabelViewCell = @"kNormalTabelViewCell";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *testArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:self.mainTableView];
    
    self.testArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger count = 0; count <= 20; count++) {
        [self.testArr addObject:@(count)];
    }
    
    [self.mainTableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.mainTableView.frame.size.height - 44 - 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.testArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNormalTabelViewCell];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
//        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kNormalTabelViewCell];
    }
    return _mainTableView;
}


@end
