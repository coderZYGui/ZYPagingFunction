//
//  ZYPageView.m
//  PagingFunction
//
//  Created by 罂粟 on 2017/10/11.
//  Copyright © 2017年 sunny. All rights reserved.
//

#import "ZYPageView.h"
#define SCROLLVWIDTH self.scrollView.frame.size.width
#define SCROLLVHEIGHT self.scrollView.frame.size.height
#define UISCREENW [UIScreen mainScreen].bounds.size.width

@interface ZYPageView()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageView;

/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation ZYPageView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 开启分页功能
    self.scrollView.pagingEnabled = YES;
    // 单页时隐藏pageView
    self.pageView.hidesForSinglePage = YES;
    // 隐藏滚动条
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    // 设置pageView的图片
    [self.pageView setValue:[UIImage imageNamed:@"current"] forKeyPath:@"_currentPageImage"];
    [self.pageView setValue:[UIImage imageNamed:@"other"] forKey:@"_pageImage"];
    
    self.scrollView.frame = CGRectMake(0, 20, UISCREENW, 160);
    self.pageView.frame = CGRectMake(250, 145, 50, 50);
    
    // 开启定时器
    [self startTimer];
    
}

+ (instancetype)page
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}


/**
 图片名数组的set方法
 
 @param imageNames 传入的图片名数组
 */
- (void)setImageNames:(NSMutableArray *)imageNames
{
    _imageNames = imageNames;
    
    // 移除之前添加的
    // 让subviews数组中每一个对象都执行一次removeFromSuperview方法
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //1.  根据图片名创建imageView并添加到scrollView上
    CGFloat scrollViewW = SCROLLVWIDTH;
    CGFloat scrollViewH = SCROLLVHEIGHT;
    NSUInteger count = self.imageNames.count;
    for (int i = 0; i < count; ++i) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNames[i]]];
        
        imageView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        [self.scrollView addSubview:imageView];
    }
    
    //2. 设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
    //3. 设置总页数
    self.pageView.numberOfPages = count;
    
}


#pragma -mark 定时器相关代码
- (void)startTimer
{
    // 返回一个自动执行的定时器对象
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
}

/**
 滚动到下一页
 */
- (void)nextPage
{
    //1. 计算下一页页码
    NSInteger page = self.pageView.currentPage + 1;
    //2. 当滚动到最后一页时,跳转到第一页
    if (page == self.imageNames.count) {
        page = 0;
    }
    //3. 滚动到下一页
    [self.scrollView setContentOffset:CGPointMake(page * SCROLLVWIDTH, 0) animated:YES];
    
}

/**
 停止定时器
 */
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma -mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.计算页码
    int page = (scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    
    // 2.设置页码
    self.pageView.currentPage = page;
}

/**
 *  用户即将开始拖拽scrollView时,停止定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

/**
 *  用户已经停止拖拽scrollView时,开启定时器
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self startTimer];
}

@end
