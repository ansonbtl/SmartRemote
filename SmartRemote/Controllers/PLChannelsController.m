//
//  PLChannelsController.m
//  SmartRemote
//
//  Created by Anson Li on 5/20/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLChannelsController.h"
#import "PLChannelListCell.h"
#import "PLWebImageLoader.h"
#import "PLChannelLineUp.h"

@interface PLChannelsController () {
    NSMutableDictionary *excludedDict;
}

@end

@implementation PLChannelsController

- (id)initWithChannels:(NSArray *)channels excludedChannels:(NSArray *)excludedChannels {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.channels = channels;
        self.excludedChannels = excludedChannels;
        
        excludedDict = [[NSMutableDictionary alloc] init];
        for (PLChannelLineUp *lineUp in self.excludedChannels) {
            [excludedDict setObject:lineUp forKey:lineUp.prgsvcid];
        }
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"All Channels";
    
    self.tableView.rowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:@"PLChannelListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(nextStep)];
    self.navigationItem.rightBarButtonItem = nextItem;
    
}

- (void)nextStep {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.channels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PLChannelListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    PLChannelLineUp *channel = self.channels[indexPath.row];
    cell.nameLabel.text = channel.name;
    cell.iconView.image = nil;
    
    BOOL excluded = [excludedDict objectForKey:channel.prgsvcid] != nil;
    cell.accessoryType = excluded ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark;
    
    NSIndexPath *index = indexPath;
    [[PLWebImageLoader instance] imageWithUrl:channel.imageUrl forceReload:YES completion:^(UIImage *image){
        if (image) {
            for (NSIndexPath *theIndex in tableView.indexPathsForVisibleRows) {
                if (theIndex.row == index.row && theIndex.section == index.section) {
                    PLChannelListCell *aCell = (PLChannelListCell *)[self.tableView cellForRowAtIndexPath:theIndex];
                    aCell.iconView.image = image;
                }
            }
        }
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PLChannelLineUp *channel = self.channels[indexPath.row];
    
    NSLog(@"url: %@", channel.imageUrl);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
