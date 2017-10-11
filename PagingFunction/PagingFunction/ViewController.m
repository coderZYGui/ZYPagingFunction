//
//  ViewController.m
//  PagingFunction
//
//  Created by 罂粟 on 2017/10/11.
//  Copyright © 2017年 sunny. All rights reserved.
//

#import "ViewController.h"
#import "ZYPageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZYPageView *page = [ZYPageView page];
    
    page.imageNames = @[
                        @"img_02",@"img_01",@"img_04",
                        @"img_05",@"img_03"
                        ];
    
    [self.view addSubview:page];
    
}



@end
