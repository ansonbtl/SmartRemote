//
//  UIViewController+extension.h
//  FarmYard
//
//  Created by Anson Li on 4/2/13.
//  Copyright (c) 2013 Anson Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (extension)

- (void)dismissViewController;
- (void)initShowMenuItem;
- (void)showRootMenu;

- (void)setBrightTheme;

- (UIImage *)screenshot;
- (UIImage *)screenshotAfterUpdate:(BOOL)afterScreenUpdate;

- (UITextField *)newTextField:(CGRect)rect;

- (BOOL)isRootController;

@end
