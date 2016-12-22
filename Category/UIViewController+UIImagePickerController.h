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
- (void)pickImage;

- (void)finishPickWithImage:(UIImage *)image;
@end
