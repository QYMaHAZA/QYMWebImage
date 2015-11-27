//
//  UIImage+QYMWebImage.m
//  手写SDWebImage
//
//  Created by mqy on 15/7/12.
//  Copyright (c) 2015年 qyma. All rights reserved.
//
//创建一个 UIImage的分类提供 下载图片的方法
#import "UIImageView+QYMWebImage.h"
#import "QYMWebImageManger.h"
#import <objc/runtime.h>
@implementation UIImageView (QYMWebImage)

const void *sandBoxKey = "sandBoxKey";
const void *urlStringKey = "urlStringKey";
- (void)setUrlString:(NSString *)urlString
{
    objc_setAssociatedObject(self, urlStringKey, urlString, OBJC_ASSOCIATION_COPY_NONATOMIC);

}
- (NSString *)urlString
{
    return  objc_getAssociatedObject(self, urlStringKey);
}

//通过运行时的方式 来创建分类的属性
- (void)setSendBox:(ReadAndWriteSandBox *)sendBox
{
      objc_setAssociatedObject(self, sandBoxKey, sendBox, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (ReadAndWriteSandBox *)sendBox
{
    return objc_getAssociatedObject(self, sandBoxKey);
}
/**
 *  根据传递过来的图片路径来下载图片
 *
 *  @param urlString <#urlString description#>
 */
- (void)setUpImageWithUrl:(NSString *)urlString
{
    //通过单例的方式创建
    QYMWebImageManger *manger = [QYMWebImageManger shareWebImageManger];
    
    //初始化沙盒缓存
    self.sendBox = [[ReadAndWriteSandBox alloc]init];
    
    
    //   从图片缓存中获取图片
    UIImage *image = [manger.images objectForKey:urlString];
    if(image)
    {
        //设置图片
        self.image  = image;
        NSLog(@"从内存缓存中获取图片");
    }else
    {
        //判断沙盒中有没有图片
        UIImage *image = [self.sendBox readImageFromSandboxByFile:urlString];
        if(image)
        {
         //设置图片
            self.image = image;
            //并且存到缓存中
            [manger.images setObject:image forKey:urlString];
            NSLog(@"从缓存中获取图片");
        }else
        {
            //判断当前传递过来的路径和正在下载的路径是否一致
            if(![self.urlString isEqualToString:urlString])
            {
             //取消之前的urlString操作
                [manger cancelQYMDownLoadOperationWith:self.urlString];
            }
            
            
            QYMDownLoadOperation *op = [manger.opertations objectForKey:urlString];
            
            if(!op)
            {
                self.urlString = urlString;
                
                __weak  typeof(self) wself = self;
                
                [manger getImageWithUrlString:urlString Block:^(UIImage *image) {
                    self.image = image;
                }];
            }
        
        }
        
       // 判断是否正在下载
    
    }
    //如果没有 判断有没有操作缓存 下载正在下载，下载不操作
    //如果没有下载图片
    
}
@end
