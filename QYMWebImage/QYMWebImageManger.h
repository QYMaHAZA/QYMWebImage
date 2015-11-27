//
//  QYMWebImageManger.h
//  手写SDWebImage
//
//  Created by mqy on 15/7/12.
//  Copyright (c) 2015年 qyma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYMDownLoadOperation.h"

typedef void(^getImageBlock)(UIImage *image);

@interface QYMWebImageManger : NSObject

//创建图片缓存
@property(nonatomic,strong)NSCache *images;

//定义队列
@property(nonatomic,strong)NSOperationQueue *queue;

//定义操作缓存
@property(nonatomic,strong)NSCache *opertations;

//定义获取要下载的url
@property(nonatomic,copy)NSString *urLString;
//创建一个单例的方法
+ (instancetype)shareWebImageManger;

//对外提供一个获取图片的方法
- (void)getImageWithUrlString:(NSString *)urlString Block:(getImageBlock)blok;

- (void)cancelQYMDownLoadOperationWith:(NSString *)UrlString;
@end
