//
//  ViewController.m
//  ScrollViewDemo
//
//  Created by Tebuy on 16/12/9.
//  Copyright © 2016年 LeeIn. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "SevenViewController.h"
#import "EightViewController.h"
#import "TitleLabel.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define titlesViewHeight 44
@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *contentView;
@property (nonatomic, strong) FirstViewController *firstVC;
@property (nonatomic, strong) SecondViewController *secondVC;
@property (nonatomic, strong) ThirdViewController *thirdVC;
@property (nonatomic, strong) FourViewController *fourVC;
@property (nonatomic, strong) FiveViewController *fiveVC;
@property (nonatomic, strong) SixViewController *sixVC;
@property (nonatomic, strong) SevenViewController *sevenVC;
@property (nonatomic, strong) EightViewController *eightVC;
@property (nonatomic, strong) TitleLabel *titleLabel;
@property (nonatomic, strong) UIScrollView *smallScrollView;
@end

@implementation ViewController
- (FirstViewController *)firstVC{
    if (!_firstVC) {
        _firstVC = [FirstViewController new];
    }
    return _firstVC;
}
- (SecondViewController *)secondVC{
    if (!_secondVC) {
        _secondVC = [SecondViewController new];
    }
    return _secondVC;
}
- (ThirdViewController *)thirdVC{
    if (!_thirdVC) {
        _thirdVC = [ThirdViewController new];
    }
    return _thirdVC;
}
- (FourViewController *)fourVC{
    if (!_fourVC) {
        _fourVC = [FourViewController new];
    }
    return _fourVC;
}
- (FiveViewController *)fiveVC{
    if (!_fiveVC) {
        _fiveVC = [FiveViewController new];
    }
    return _fiveVC;
}
- (SixViewController *)sixVC{
    if (!_sixVC) {
        _sixVC = [SixViewController new];
    }
    return _sixVC;
}
- (SevenViewController *)sevenVC{
    if (!_sevenVC) {
        _sevenVC = [SevenViewController new];
    }
    return _sevenVC;
}
- (EightViewController *)eightVC{
    if (!_eightVC) {
        _eightVC = [EightViewController new];
    }
    return _eightVC;
}
- (void)addLabel{
    UIView *indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, 50, 2)];
    indicatorView.backgroundColor = [UIColor orangeColor];
    for (int i = 0; i < 8; i ++ ) {
        CGFloat lblW = 70;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        TitleLabel *lbl1 = [[TitleLabel alloc]init];
        UIViewController *vc = self.childViewControllers[i];
        lbl1.text = vc.title;
        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);
        lbl1.font = [UIFont systemFontOfSize:19];
        [self.smallScrollView addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)]];
    }
    self.smallScrollView.contentSize = CGSizeMake(70 * 8, 0);
    TitleLabel *titleLabel = [self.smallScrollView.subviews firstObject];
    titleLabel.scale = 1.0;
}
- (void)lblClick:(UITapGestureRecognizer *)tap{
    TitleLabel *titleLabel = (TitleLabel *)tap.view;
    CGFloat offSetX = titleLabel.tag * self.contentView.frame.size.width;
    CGFloat offSetY = self.contentView.contentOffset.y;
    CGPoint offSet = CGPointMake(offSetX, offSetY);
    [self.contentView setContentOffset:offSet animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViewControllers];
    [self setupContentView];
    [self setupTitleScrollView];
    [self addLabel];
}
- (void)setupTitleScrollView{
    self.smallScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64 , ScreenWidth, titlesViewHeight)];
    self.smallScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.smallScrollView];
    
    self.smallScrollView.showsVerticalScrollIndicator = NO;
    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    self.smallScrollView.scrollsToTop = NO;

}
- (void)setupViewControllers{
    self.firstVC.title = @"数学";
    self.secondVC.title = @"语文";
    self.thirdVC.title = @"英语";
    self.fourVC.title = @"物理";
    self.fiveVC.title = @"生物";
    self.sixVC.title = @"地理";
    self.sevenVC.title = @"政治";
    self.eightVC.title = @"历史";
    [self addChildViewController:self.firstVC];
    [self addChildViewController:self.secondVC];
    [self addChildViewController:self.thirdVC];
    [self addChildViewController:self.fourVC];
    [self addChildViewController:self.fiveVC];
    [self addChildViewController:self.sixVC];
    [self addChildViewController:self.sevenVC];
    [self addChildViewController:self.eightVC];

}
- (void)setupContentView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _contentView.contentSize = CGSizeMake(_contentView.frame.size.width * self.childViewControllers.count, _contentView.frame.size.height);
    _contentView.delegate = self;
    _contentView.pagingEnabled = YES;
    [self.view insertSubview:_contentView atIndex:0];
    [self scrollViewDidEndScrollingAnimation:_contentView];
}
#pragma mark scrollViewDelegate
//产生动画的时候
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //获得索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    TitleLabel *titleLabel = (TitleLabel *)self.smallScrollView.subviews[index];
    CGFloat offsetx = titleLabel.center.x - self.smallScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMaxX = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMaxX){
        offsetx = offsetMaxX;
    }
    CGPoint offset = CGPointMake(offsetx, self.smallScrollView.contentOffset.y);
    [self.smallScrollView setContentOffset:offset animated:YES];
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    [scrollView addSubview:vc.view];

    [self.smallScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != index) {
            TitleLabel *temlabel = self.smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
}
//停止滚动时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftindex = (int)value;
    NSUInteger rightIndex = leftindex + 1;
    CGFloat scaleRight = value - leftindex;
    CGFloat scaleLeft = 1 - scaleRight;
    TitleLabel *labelLeft = self.smallScrollView.subviews[leftindex];
    labelLeft.scale = scaleLeft;
    if (rightIndex < self.smallScrollView.subviews.count) {
        TitleLabel *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
