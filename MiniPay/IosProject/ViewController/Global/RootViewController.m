//
//  RootViewController.m
//  CQRCBank_iPhone
//
//  Created by magicmac on 12-12-13.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import "RootViewController.h"
#import "DataManager.h"
#import "UINavigationBar+CustomNavImage.h"
#import "ScofieldCustomNavigationBar.h"


#define tag_tabBarSelectImageView 1000
#define  isDebug NO

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
         [self loadRootViewController];
    }
    return self;
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    
}

#pragma mark - // Optional UITabBarControllerDelegate method.

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    BOOL should = YES;
    if(tabBarController.selectedViewController == viewController) {
        should = NO;
    }
    
    return should;
}

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{
    
    [self changeTabbarSelectImageWithIndex:[tabBarController.viewControllers indexOfObject:viewController]];
}



// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController
didEndCustomizingViewControllers:(NSArray *)viewControllers
                 changed:(BOOL)changed
{
}

#pragma mark - // 改变 tabbar 的按钮图片
- (void)changeTabbarSelectImageWithIndex:(int)index {
    UIImageView *selectImageView = (UIImageView *)[self.tabBar viewWithTag:tag_tabBarSelectImageView];
    switch (index) {
        case 0:
            selectImageView.image = [UIImage imageNamed:kImage_TabbarSelect0];
            break;
        case 1:
            selectImageView.image = [UIImage imageNamed:kImage_TabbarSelect1];
            break;
        case 2:
            selectImageView.image = [UIImage imageNamed:kImage_TabbarSelect2];
            break;

        case 3:
            selectImageView.image = [UIImage imageNamed:kImage_TabbarSelect3];
            break;

        
        default:
            break;
    }
    
}

#pragma mark -

-(int)getTabSelectedIndex
{
    return  self.selectedIndex;
}

#pragma mark - Private Method

- (void)loadRootViewController
{
    
    SlotCardViewController *viewController1 =nil;
    if(kIsIphone5)
        viewController1=[[SlotCardViewController alloc]initWithNibName:@"SlotCardViewController_iphone5" bundle:nil];
    else
        viewController1=[[SlotCardViewController alloc]initWithNibName:@"SlotCardViewController" bundle:nil];
    
    NSString *navBgImgname=@"";
    if(kSystemVersion>=7.0){
        navBgImgname=kImage_NavigationBarBg7;
    }else{
        navBgImgname=kImage_NavigationBarBg;
    }
    
    UINavigationController *uiNavController1 = [[UINavigationController alloc]initWithRootViewController:viewController1];
    [uiNavController1.navigationBar setNavigationBarBackgroundImageName:navBgImgname];
    self.cardNavigationController = uiNavController1;
    
    FlowViewController *viewController2 = [[FlowViewController alloc]init];
    UINavigationController *uiNavController2 = [[UINavigationController alloc]initWithRootViewController:viewController2];
    [uiNavController2.navigationBar setNavigationBarBackgroundImageName:navBgImgname];
    self.flowNavigationController = uiNavController2;
    
    MerchantIndexViewController *viewController3 = [[MerchantIndexViewController alloc]init];
    UINavigationController *uiNavController3 = [[UINavigationController alloc]initWithRootViewController:viewController3];
    [uiNavController3.navigationBar setNavigationBarBackgroundImageName:navBgImgname];
    self.merchantNavigationController = uiNavController3;
    
    ToolIndexViewController *viewController4 = [[ToolIndexViewController alloc]init];
    UINavigationController *uiNavController4 = [[UINavigationController alloc]initWithRootViewController:viewController4];
    [uiNavController4.navigationBar setNavigationBarBackgroundImageName:navBgImgname];
    self.toolNavigationController = uiNavController4;

    
    
    self.viewControllers = [NSArray arrayWithObjects:self.cardNavigationController,self.flowNavigationController,self.merchantNavigationController,self.toolNavigationController,nil];
    
    // add bg
    UIImageView *tabBarImageView = [[UIImageView alloc] init];
    tabBarImageView.frame = CGRectMake(0, -1, 320, 50);
    tabBarImageView.image = [UIImage imageNamed:kImage_TabbarBg];
    [self.tabBar addSubview:tabBarImageView];
    [self.tabBar bringSubviewToFront:tabBarImageView];
    
    UIImageView *tabBarSelectImageView = [[UIImageView alloc] initWithFrame:tabBarImageView.bounds];
    tabBarSelectImageView.image = [UIImage imageNamed:kImage_TabbarSelect0];
    tabBarSelectImageView.tag = tag_tabBarSelectImageView;
    [tabBarImageView addSubview:tabBarSelectImageView];
    
    
    self.delegate = self;
}





@end
