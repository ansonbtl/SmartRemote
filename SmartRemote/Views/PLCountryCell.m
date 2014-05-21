//
//  PLCountryCell.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLCountryCell.h"
#import "PLUtility.h"

@implementation PLCountryCell


- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = [PLUtility themeLightBackgroundColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
