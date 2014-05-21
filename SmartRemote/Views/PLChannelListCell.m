//
//  PLChannelListCell.m
//  SmartRemote
//
//  Created by Anson Li on 5/20/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLChannelListCell.h"
#import "PLUtility.h"

@implementation PLChannelListCell

- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = [PLUtility themeLightBackgroundColor];
    self.nameLabel.textColor = [PLUtility themeTextColor];
    self.accessoryType = UITableViewCellAccessoryCheckmark;
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
