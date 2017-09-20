//
//  BaseViewController.m
//  Mushroom
//
//  Created by 中原管家 on 2017/9/13.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

///  baseVC的BviewModel，外部只是暴露getter属性
@property (nonatomic, strong) BaseViewModel *viewModel;

@end

@implementation BaseViewController

- (instancetype)initWithViewModel:(BaseViewModel *)viewModel
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 这里的基类ViewModel实现的title是nil，如果子类实现，就能获取到对应的子类控制器标题
    self.title = _viewModel.title;
}

- (void)initView
{
    // 具体子类实现
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)initBinding
{
    [self.viewModel sendRequest:^(id entity) {
        
        
    } failure:^(NSUInteger errCode, NSString *errorMsg) {
        
        showMessage(errorMsg, self);
    }];
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
