//
//  PLChannelsController.h
//  SmartRemote
//
//  Created by Anson Li on 5/20/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLBaseTableViewController.h"

@interface PLChannelsController : PLBaseTableViewController

@property(nonatomic, strong) NSArray *channels, *excludedChannels;

- (id)initWithChannels:(NSArray *)channels excludedChannels:(NSArray *)excludedChannels;

@end
