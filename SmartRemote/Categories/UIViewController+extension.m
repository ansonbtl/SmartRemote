//
//  UIViewController+extension.m
//  FarmYard
//
//  Created by Anson Li on 4/2/13.
//  Copyright (c) 2013 Anson Li. All rights reserved.
//

#import "UIViewController+extension.h"
#import "PLUtility.h"

@implementation UIViewController (extension)

- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)showRootMenu {
    [self.navigationController.parentViewController performSelector:@selector(showOrHideMenu)];
}

- (UIImage *)screenshot {
    return [self screenshotAfterUpdate:YES];
}

- (UIImage *)screenshotAfterUpdate:(BOOL)afterScreenUpdate {
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, [UIScreen mainScreen].scale);
    
    [self.view drawViewHierarchyInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UITextField *)newTextField:(CGRect)rect {
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    textField.font = [UIFont systemFontOfSize:16];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    return textField;
}

- (BOOL)isRootController {
    return [self.navigationController.viewControllers objectAtIndex:0] == self;
}

@end
