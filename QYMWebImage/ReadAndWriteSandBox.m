//
//  ReadAndWriteSandBox.m
//  01-app展示
//
//  Created by 李凯宁 on 15/5/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ReadAndWriteSandBox.h"

@implementation ReadAndWriteSandBox

// 获取 Caches 文件路径
- (NSString *)getSandboxCachesByAddFilename:(NSString *)filename
{
    // 得到 Caches 路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    // 拼接文件路径
    if (filename) {
        NSString *file = [path stringByAppendingPathComponent:filename.lastPathComponent];
        return file;
    }else{
        return path;
    }
    
}

// 从沙盒中获取图片
- (UIImage *)readImageFromSandboxByFile:(NSString *)filename
{
    // 获得完整的图片路径
    NSString *file = [self getSandboxCachesByAddFilename:filename];
    // 根据图片路径,获得沙盒图片
    UIImage *image = [UIImage imageWithContentsOfFile:file];
    // 返回沙盒存储的图片
    return image;
}
// 将图片写入沙盒
- (void)writeImage:(UIImage *)image ToSandboxFile:(NSString *)fileName
{
    // 拼接完整的图片路径
    NSString *file = [self getSandboxCachesByAddFilename:fileName];
    
    // 将图片转换为 PNG 格式的二进制数据
    NSData *data = UIImagePNGRepresentation(image);
    
    // 按顺序将图片写入沙盒中.
    [data writeToFile:file atomically:YES];
    
}

@end
