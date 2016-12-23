//
//  UIViewController+UIImagePickerController.h
//  sishi
//
//  Created by likeSo on 2016/12/22.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 用于展示"选择照片"/"拍摄照片"弹窗的picker
 */
@interface UIViewController (UIImagePickerController)<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/**
 *  标识符,每次调用pickImage时都会被刷新
 */
@property(nonatomic,copy)NSString *identifier;

- (void)pickImage:(NSString *)identifier;

- (void)finishPickWithImage:(UIImage *)image identifier:(NSString *)identifier;
@end
