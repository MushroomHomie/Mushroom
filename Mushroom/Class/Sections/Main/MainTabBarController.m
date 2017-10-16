//
//  MainTabBarController.m
//  myMusicApp
//
//  Created by 11_wyq on 15/6/14.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomePageVC.h"
#import "ClassifyVC.h"
#import "LiveTelecastVC.h"
#import "V_ListVC.h"
#import "RadioFM_VC.h"
#import "MainNavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    myView.backgroundColor = [UIColor blackColor];
    [self.tabBar insertSubview:myView atIndex:1];
    self.tabBar.translucent = YES;
    
    NSArray *titles = @[@"首页",@"分类",@"V榜",@"直播",@"电台"];
    NSArray *classNames = @[@"HomePageVC",@"ClassifyVC",@"V_ListVC",@"LiveTelecastVC",@"RadioFM_VC"];
    NSArray *images = @[@"tabbar_home_50x50_",@"tabbar_fl_50x50_",@"tabbar_vchart_50x50_",@"tabbar_tv_50x50_",@"tabbar_mine_50x50_"];
    NSArray *selectImages = @[@"tabbar_home_sel_50x50_",@"tabbar_fl_sel_50x50_",@"tabbar_vchart_sel_50x50_",@"tabbar_tv_p_50x50_",@"tabbar_mine_sel_50x50_"];

    for (int i = 0; i < titles.count; i++)
    {
        Class class = NSClassFromString(classNames[i]);
        id pClass = [[class alloc] init];
        [self addChildViewController:pClass
                               Title:titles[i]
                            angImage:[UIImage imageNamed:images[i]]
                      AndSelectImage:[UIImage imageNamed:selectImages[i]]];
    }
}

- (void)addChildViewController:(UIViewController *)childController Title:(NSString *)title angImage:(UIImage *)image AndSelectImage:(UIImage *)selectImage
{
    childController.title = title;
    
    // 点击前图片
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.image = image;
    // 点击后图片
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectImage;
    
    // 点击前字体颜色
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    // 点击后字体颜色
    NSMutableDictionary *selectTextAttr = [NSMutableDictionary dictionary];
    selectTextAttr[NSForegroundColorAttributeName] = RGBColor(28, 185, 112);
    
    [childController.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:selectTextAttr forState:UIControlStateSelected];
    
    MainNavigationController *naVC = [[MainNavigationController alloc]initWithRootViewController:childController];
    naVC.navigationBar.translucent = NO;
    
    // 设置导航栏颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [self addChildViewController:naVC];
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
