//
//  QYMDownLoadOperation.h
//  手写SDWebImage
//
//  Created by mqy on 15/7/12.
//  Copyright (c) 2015年 qyma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ReadAndWriteSandBox.h"
@class QYMDownLoadOperation;

typedef void(^setUpImageBlock)(QYMDownLoadOperation *op);

@interface QYMDownLoadOperation : NSOperation

//定义一个用来保存传递过来的下载路径
@property(nonatomic,copy)NSString *urlString;
//定义一个Block属性
@property(nonatomic,copy)setUpImageBlock block;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)ReadAndWriteSandBox *sendBox;

//传递一个block
- (void)setUpImageWithBlock:(setUpImageBlock)blok;
@end
