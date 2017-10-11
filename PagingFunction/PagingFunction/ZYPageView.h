//
//  ZYPageView.h
//  PagingFunction
//
//  Created by 罂粟 on 2017/10/11.
//  Copyright © 2017年 sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYPageView : UIView

/** 图片名数组 */
@property (nonatomic, strong) NSArray *imageNames;

/**
 快速创建对象的类工厂方法
 */
+ (instancetype)page;

@end

