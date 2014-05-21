//
//  PLLineUp.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLLineUp : NSObject

@property(nonatomic, strong) NSString *name, *boxType, *channelDifference, *headEndId;
@property(nonatomic, assign) int lineUpCount;
@property(nonatomic, strong) NSString *mso, *split, *type;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
