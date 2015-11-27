//
//  ReadAndWriteSandBox.h
//  01-app展示
//
//  Created by 李凯宁 on 15/5/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ReadAndWriteSandBox : NSObject

// 获取 Caches 路径
- (NSString *)getSandboxCachesByAddFilename:(NSString *)filename;
// 读取沙盒文件
- (UIImage *)readImageFromSandboxByFile:(NSString *)filename;
// 写入沙盒文件
- (void)writeImage:(UIImage *)image ToSandboxFile:(NSString *)fileName;



@end
