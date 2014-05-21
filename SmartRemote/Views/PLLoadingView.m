//
//  PLLoadingView.m
//  SmartRemote
//
//  Created by Anson Li on 5/20/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLLoadingView.h"

@implementation PLLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = .45;
        [self addSubview:bgView];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicatorView.frame = CGRectMake((self.bounds.size.width - 30)/2.0, (self.bounds.size.height - 30)/2.0 - 15, 30, 30);
        _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:_indicatorView];
        
        [_indicatorView startAnimating];
        
        self.alpha = 0.0;
    }
    return self;
}

- (void)appear {
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)fade {
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

@end
