//
//  MainViewController.m
//  TestTableviewContainTableVIew
//
//  Created by 钟伟杰 on 2020/2/5.
//  Copyright © 2020 钟伟杰. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    [button setTitle:@"进入" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enterAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)enterAction {
    UIViewController *TbVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:TbVC animated:YES];
}

@end
