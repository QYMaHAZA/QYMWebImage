//
//  UIImage+QYMWebImage.h
//  手写SDWebImage
//
//  Created by mqy on 15/7/12.
//  Copyright (c) 2015年 qyma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadAndWriteSandBox.h"

@interface UIImageView (QYMWebImage)

- (void)setUpImageWithUrl:(NSString *)urlString;

//给分类设置一个属性，从沙盒中获取
@property(nonatomic,strong)ReadAndWriteSandBox *sendBox;

//定义一个属性 用来对比当前下载的路径和之前的对比
@property(nonatomic,strong)NSString *urlString;
@end
