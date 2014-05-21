//
//  PLLoadingView.h
//  SmartRemote
//
//  Created by Anson Li on 5/20/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLLoadingView : UIView

@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;

- (void)appear;
- (void)fade;

@end
