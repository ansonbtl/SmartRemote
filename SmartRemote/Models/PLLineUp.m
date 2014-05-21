//
//  PLLineUp.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLLineUp.h"

@implementation PLLineUp

- (id)initWithDictionary:(NSDictionary *)dict {
    PLLineUp *lineUp = [[PLLineUp alloc] init];
    
    lineUp.name = dict[@"name"];
    lineUp.boxType = dict[@"boxtype"];
    lineUp.channelDifference = dict[@"channelDifference"];
    lineUp.headEndId = dict[@"headendid"];
    lineUp.lineUpCount = [dict[@"lineupcount"] intValue];
    lineUp.mso = dict[@"mso"];
    lineUp.split = dict[@"split"];
    lineUp.type = dict[@"type"];
    
    return lineUp;
}

@end
