//
//  PLAppShared.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLAppShared.h"

@implementation PLAppShared

+ (PLAppShared *)instance {
    static PLAppShared *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[PLAppShared alloc] init];
        
        [instance initData];
    });
    
    return instance;
}

- (void)initData {
    _networkQueue = [[NSOperationQueue alloc] init];
    _IOQueue = dispatch_queue_create("com.peel.io", nil);
    
}

@end
