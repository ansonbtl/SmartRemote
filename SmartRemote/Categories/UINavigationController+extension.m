//
//  UINavigationController+extension.m
//  School
//
//  Created by Anson Li on 8/23/13.
//  Copyright (c) 2013 Anson Li. All rights reserved.
//

#import "UINavigationController+extension.h"

@implementation UINavigationController (extension)

- (BOOL)isRootController:(UIViewController *)controller {
    return [self.viewControllers objectAtIndex:0] == self;
}

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.childViewControllers.lastObject;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.childViewControllers.lastObject preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden {
    return [self.childViewControllers.lastObject prefersStatusBarHidden];
}

@end
