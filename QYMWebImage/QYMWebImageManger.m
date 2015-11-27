//
//  QYMWebImageManger.m
//  手写SDWebImage
//
//  Created by mqy on 15/7/12.
//  Copyright (c) 2015年 qyma. All rights reserved.
//

#import "QYMWebImageManger.h"

@implementation QYMWebImageManger
/**
 *  一个单例对象
 *
 *  @return  返回单例的对象
 */
+ (instancetype)shareWebImageManger
{
    static id _instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init ];
    });
    return _instance;
}
- (NSCache *)images
{
    if(!_images)
    {
        _images = [[NSCache alloc]init];
    }
    return _images;
}

- (NSCache *)opertations
{
    if(!_opertations)
    {
        _opertations = [[NSCache alloc]init];
    }
    return _opertations;
}
//队列  设置最大开启线程数为6
- (NSOperationQueue *)queue
{
    if(!_queue)
    {
        _queue = [[NSOperationQueue alloc]init];
        [_queue setMaxConcurrentOperationCount:6];
    }

    return _queue;
}
- (void)cancelQYMDownLoadOperationWith:(NSString *)UrlString
{
//取消单个操作
    QYMDownLoadOperation *op  = [self.opertations objectForKey:UrlString];
    
    [op cancel];
   NSLog(@"取消操作%@",UrlString);
}

- (void)getImageWithUrlString:(NSString *)urlString Block:(getImageBlock)blok
{
    //创建一个操作
    QYMDownLoadOperation *myOperation = [[QYMDownLoadOperation alloc]init];
    
    myOperation.urlString = urlString;
    
    //将操作保存在操作缓存中
    [self.opertations setObject:myOperation forKey:self.urLString];

    //设置显示图片,实现设置图片在主线程
    [myOperation setUpImageWithBlock:^(QYMDownLoadOperation *myOperation) {
        if(myOperation.image)
        {
            blok(myOperation.image);
            //将图片保存在图片缓存中
            [self.images setObject:myOperation.image forKey:self.urLString];
        }

        //删除操作缓存
        [self.opertations removeAllObjects];
    }];
    
    //将操作添加到队列里面
    [self.queue addOperation:myOperation];

}
@end
