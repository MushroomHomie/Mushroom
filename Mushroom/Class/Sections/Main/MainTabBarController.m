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

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    myView.backgroundColor = [UIColor blackColor];
    [self.tabBar insertSubview:myView atIndex:1];
    self.tabBar.translucent = YES;
    
    // 首页
    HomePageVC *homepageVC = [[HomePageVC alloc]init];
    [self addChildViewController:homepageVC Title:@"首页" angImage:[UIImage imageNamed:@"tab_icon_home@2x.png"] AndSelectImage:[UIImage imageNamed:@"tab_icon_home_sel@2x.png"]];
    
    // 分类
    ClassifyVC *classifyVC = [[ClassifyVC alloc]init];
    [self addChildViewController:classifyVC Title:@"分类" angImage:[UIImage imageNamed:@"btn_bar_recommend@2x.png"] AndSelectImage:[UIImage imageNamed:@"btn_bar_recommend_on@2x.png"]];
    
    // V榜
    V_ListVC *v_ListVC = [[V_ListVC alloc]init];
    [self addChildViewController:v_ListVC Title:@"V榜" angImage:[UIImage imageNamed:@"btn_bar_recommend@2x.png"] AndSelectImage:[UIImage imageNamed:@"btn_bar_recommend_on@2x.png"]];
    
    // 直播
    LiveTelecastVC *liveTelecastVC = [[LiveTelecastVC alloc]init];
    [self addChildViewController:liveTelecastVC Title:@"直播" angImage:[UIImage imageNamed:@"tab_icon_hot@2x.png"] AndSelectImage:[UIImage imageNamed:@"tab_icon_hot_sel@2x.png"]];
    
    // 音乐电台
    RadioFM_VC *musicFM = [[RadioFM_VC alloc]init];
    [self addChildViewController:musicFM Title:@"电台" angImage:[UIImage imageNamed:@"btn_bar_radio@2x.png"] AndSelectImage:[UIImage imageNamed:@"btn_bar_radio_on@2x.png"]];
}

- (void)addChildViewController:(UIViewController *)childController Title:(NSString *)title angImage:(UIImage *)image AndSelectImage:(UIImage *)selectImage
{
    childController.title = title;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textColor = [UIColor orangeColor];
    
    // 点击前图片
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.image = image;
    // 点击后图片
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectImage;
    
    // 点击前字体颜色
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 点击后字体颜色
    NSMutableDictionary *selectTextAttr = [NSMutableDictionary dictionary];
    selectTextAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childController.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:selectTextAttr forState:UIControlStateSelected];
    
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:childController];
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
