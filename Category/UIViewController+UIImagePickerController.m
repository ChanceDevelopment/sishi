//
//  UIViewController+UIImagePickerController.m
//  sishi
//
//  Created by likeSo on 2016/12/22.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "UIViewController+UIImagePickerController.h"
#import <objc/runtime.h>

@implementation UIViewController (UIImagePickerController)
- (void)setIdentifier:(NSString *)identifier {
    objc_setAssociatedObject(self, @selector(identifier), identifier, OBJC_ASSOCIATION_COPY);
}

- (NSString *)identifier {
    return objc_getAssociatedObject(self, @selector(identifier));
}

- (void)pickImage:(NSString *)identifier {
    self.identifier = identifier;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择照片打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"现在拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePicker.sourceType  = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
     [alert addAction:cameraAction];
    [alert addAction:albumAction];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([self respondsToSelector:@selector(finishPickWithImage:identifier:)]) {
        UIImage *editedImage = (UIImage *)info[UIImagePickerControllerEditedImage];
        [self finishPickWithImage:editedImage identifier:self.identifier];
    }
}
@end
