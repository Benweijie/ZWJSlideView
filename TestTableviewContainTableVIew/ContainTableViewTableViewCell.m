//
//  ContainTableViewTableViewCell.m
//  TestTableviewContainTableVIew
//
//  Created by 钟伟杰 on 2020/2/6.
//  Copyright © 2020 钟伟杰. All rights reserved.
//

#import "ContainTableViewTableViewCell.h"

static NSString *const kSubTableViewCell = @"kSubTableViewCell";

@interface ContainTableViewTableViewCell ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *subTableView;
@property (nonatomic, assign) NSInteger indexNumber;

@end

@implementation ContainTableViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self.contentView addSubview:self.subTableView];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.subTableView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSubTableViewCell];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-第%ld行", self.indexNumber, indexPath.row];
    
    return cell;
}

- (void)setupCell:(NSInteger)index {
    self.indexNumber = index;
    [self.subTableView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (UITableView *)subTableView {
    if (!_subTableView) {
        _subTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height) style:UITableViewStylePlain];
        _subTableView.delegate = self;
        _subTableView.dataSource = self;
        _subTableView.bounces = NO;
        [_subTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSubTableViewCell];
    }
    
    return _subTableView;
}

@end
