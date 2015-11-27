//
//  QYMDownLoadOperation.m
//  手写SDWebImage
//
//  Created by mqy on 15/7/12.
//  Copyright (c) 2015年 qyma. All rights reserved.
//

#import "QYMDownLoadOperation.h"

@implementation QYMDownLoadOperation
//重写main方法
- (void)main
{
    @autoreleasepool {
        //获取下载的图片
        self.image = [self downLoadImageWithString:self.urlString];

        //在主线程中显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(self.block)
            {
                self.block(self);
            }
        });
    }
}
- (ReadAndWriteSandBox *)sendBox
{
    if(!_sendBox)
    {
        _sendBox = [[ReadAndWriteSandBox alloc]init];
    }
    return _sendBox;

}
- (void)setUpImageWithBlock:(setUpImageBlock)blok
{
    if(blok)
    {
        self.block = blok;
    }
}
- (UIImage *)downLoadImageWithString:(NSString *)urlString
{
    if (self.isCancelled) {
        return nil;
    }
    [NSThread sleepForTimeInterval:1];
    if (self.isCancelled) {
        return nil;
    }
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (self.isCancelled) {
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if (self.isCancelled) {
        return nil;
    }
    //将数据存储到沙盒缓存中
    if(data)
    {
        [data writeToFile:[self.sendBox getSandboxCachesByAddFilename:urlString] atomically:YES];
    }
    
    UIImage *image = [UIImage imageWithData:data];
    return image;
}
@end
