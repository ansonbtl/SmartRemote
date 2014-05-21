//
//  PLSelectionView.h
//  SmartRemote
//
//  Created by Anson Li on 5/15/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <UIKit/UIKit.h>

/////////////////////////////////////////////
// This is a selection control
// with a topbar containing an icon, a text title & a close button
// the table view provides the select function
/////////////////////////////////////////////


@protocol PLSelectionViewDelegate <NSObject>

// value is the data to store
- (void)didSelectValue:(id)selectedValue;
// title is the localized string to show to users
- (void)didSelectTitle:(NSString *)selectedTitle;

@end

@interface PLSelectionView : UIView {

}

- (id)initWithFrame:(CGRect)frame withBackgroundImage:(UIImage *)backgroundImage;

- (void)setTitles:(NSArray *)titles withValues:(NSArray *)values;

@end
