//
//  PLChannelListCell.h
//  SmartRemote
//
//  Created by Anson Li on 5/20/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLChannelListCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UIImageView *iconView, *checkImage;
@property(nonatomic, strong) IBOutlet UILabel *nameLabel;

@end
