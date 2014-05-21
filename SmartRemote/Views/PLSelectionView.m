//
//  PLSelectionView.m
//  SmartRemote
//
//  Created by Anson Li on 5/15/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLSelectionView.h"

@interface PLSelectionView() <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    UIImageView *_backgroundView;
    
    UIView *_topbar;
    UILabel *_topLabel;
    UIImageView *_topIcon;
    UIButton *_closeButton;
}

@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, strong) NSArray *values;

@end

@implementation PLSelectionView

- (id)initWithFrame:(CGRect)frame withBackgroundImage:(UIImage *)backgroundImage
{
    self = [super initWithFrame:frame];
    if (self) {
        // blur background image
        _backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundView.image = backgroundImage;
        [self addSubview:_backgroundView];
        
        [self initTopBar];
        [self initTableView];
        
        [self animateIn];
    }
    return self;
}

- (void)initTopBar {
    CGFloat height = 320;
    _topbar = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - height - 44, self.frame.size.width, 44)];
    [self addSubview:_topbar];
    
    CGFloat topViewWidth = 250;
    CGFloat topViewHeight = 28;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - topViewWidth)/2.0, (44 - topViewHeight)/2.0, topViewWidth, topViewHeight)];
    [_topbar addSubview:topView];
    
    _topIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 28, 28)];
    _topIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [topView addSubview:_topIcon];
    
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(_topIcon.frame.size.width - 4, 0, topView.frame.size.width - _topIcon.frame.size.width - 4, topView.frame.size.height)];
    _topLabel.backgroundColor = [UIColor clearColor];
    _topLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [topView addSubview:_topIcon];

    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.frame = CGRectMake(_topbar.frame.size.width - 40, 4, 36, 36);
    [_topbar addSubview:_closeButton];
    [_closeButton addTarget:self action:@selector(closeThis) forControlEvents:UIControlEventTouchUpInside];
    
    // setup view layout constraints
    // we need label always to fit it's content
    // and icon view sits next to it
    
    // top label constraints
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_topLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_topLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *center = [NSLayoutConstraint constraintWithItem:_topLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:topView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:_topLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:topView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    width.priority = UILayoutPriorityDefaultLow;
    
    // icon constraints
    NSLayoutConstraint *iconWidth = [NSLayoutConstraint constraintWithItem:_topIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60];
    NSLayoutConstraint *iconHeight = [NSLayoutConstraint constraintWithItem:_topIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    
    NSLayoutConstraint *iconCenterY = [NSLayoutConstraint constraintWithItem:_topIcon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:topView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:7];
    NSLayoutConstraint *iconRight = [NSLayoutConstraint constraintWithItem:_topIcon attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_topLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:5];
    
    NSArray *contraints = @[top, bottom, center, width, iconWidth, iconHeight, iconCenterY, iconRight];
    [topView addConstraints:contraints];
}

- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_tableView];
    
    // fixed height
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:320];
    // stick to superview left
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    // stick to superview right
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    // stick to superview bottom
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    NSArray *constraints = @[height, left, right, bottom];
    [self addConstraints:constraints];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void)setTitles:(NSArray *)titles withValues:(NSArray *)values {
    
}

- (void)animateIn {
    
}

- (void)animateOut {
    
}

- (void)closeThis {
    [self animateOut];
    
}

#pragma mark - tableview data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    NSString *title = self.titles[indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}


@end
