//
//  PLProvidersController.m
//  SmartRemote
//
//  Created by Anson Li on 5/20/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLProvidersController.h"
#import "PLChannelsController.h"
#import "PLCloudManager.h"
#import "PLLineUp.h"
#import "PLUtility.h"
#import "PLLoadingView.h"
#import "PLChannelLineUp.h"
#import "PLDataManager.h"
#import "PLProvider.h"
#import "PLUserChannel.h"
#import "PLRoom.h"

@interface PLProvidersController () {
    PLLoadingView *loadingIndicator;
}

@property(nonatomic, strong) NSArray *lineUps;
@property(nonatomic, strong) PLLineUp *lineUp;

@end

@implementation PLProvidersController

- (id)initWithLineUps:(NSArray *)lineUps {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.lineUps = lineUps;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.rowHeight = 60;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"FIND SERVICE PROVIDER";
}

- (void)viewDidDisappear:(BOOL)animated {
    loadingIndicator = nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lineUps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    cell.backgroundColor = [PLUtility themeLightBackgroundColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    PLLineUp *lineUp = [self.lineUps objectAtIndex:indexPath.row];
    cell.textLabel.text = lineUp.mso;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", lineUp.name, lineUp.type];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PLLineUp *lineUp = [self.lineUps objectAtIndex:indexPath.row];
    
    NSString *lineUpCode = lineUp.headEndId;
    self.lineUp = lineUp;
    
    [self nextStepWithCode:lineUpCode];
}

- (void)nextStepWithCode:(NSString *)lineUpCode {
    if (loadingIndicator) {
        [loadingIndicator removeFromSuperview];
        loadingIndicator = nil;
    }
    
    loadingIndicator = [[PLLoadingView alloc] initWithFrame:self.view.bounds];
    [loadingIndicator appear];
    [self.view addSubview:loadingIndicator];
    
    [[PLCloudManager instance] channelLineUpsWithCode:lineUpCode completion:^(int code, NSArray *channels) {
        [[PLCloudManager instance] excludedChannelLineUpsWithCode:lineUpCode completion:^(int code, NSArray *excludedChannels){
            dispatch_async(dispatch_get_main_queue(), ^{
                [loadingIndicator removeFromSuperview];
                loadingIndicator = nil;
                
                if (code == 1 && channels.count > 0) {
                    [self selectedChannels:channels excludedChannels:excludedChannels];
                }
            });
        }];
    }];
}

- (void)selectedChannels:(NSArray *)channels excludedChannels:(NSArray *)excludedChannels {
    // Go to channel list
    //PLChannelsController *controller = [[PLChannelsController alloc] initWithChannels:channels excludedChannels:excludedChannels];
    //[self.navigationController pushViewController:controller animated:YES];
    
    NSManagedObjectContext *tempContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    tempContext.parentContext = [PLDataManager instance].dataContext;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // store user preferences to db
        // create room
        // create provider
        // create channel list
        NSMutableDictionary *excludedDict = [[NSMutableDictionary alloc] init];
        for (PLChannelLineUp *lineUp in excludedChannels) {
            [excludedDict setObject:lineUp forKey:lineUp.prgsvcid];
        }
                PLRoom *room = [PLRoom newRoomWithContext:tempContext];
        PLProvider *provider = [PLProvider newProviderWithContext:tempContext];
        [provider setValuesWithLineUp:self.lineUp];
        
        room.providerID = provider.uniqueID;
        
        for (PLChannelLineUp *lineUp in channels) {
            PLUserChannel *channel = [PLUserChannel newUserChannelWithContext:tempContext];
            [channel setValuesWithChannelLineUp:lineUp];
            channel.providerID = provider.uniqueID;
            channel.selected = [excludedDict objectForKey:lineUp.prgsvcid] == nil ? @YES : @NO;
            channel.roomID = room.uniqueID;
        }
        
        // save current context
        // push data to parent context
        // back to main queue and continue
        [tempContext performBlock:^{
            [tempContext save:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        }];
    });
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
