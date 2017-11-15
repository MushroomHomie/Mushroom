//
//  VideoPlayVC.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/15.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "VideoPlayVC.h"
#import "VideoPlayVM.h"

@interface VideoPlayVC ()

@property (nonatomic, strong) VideoPlayVM *viewModel;

@end

@implementation VideoPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData
{
    self.viewModel = [VideoPlayVM new];
}

#pragma mark - CommonMethod

- (Class)cellClassForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCell.class;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
