//
//  PLAppShared.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLAppShared : NSObject

// this queue is designed for network calls
@property(nonatomic, readonly) NSOperationQueue *networkQueue;
// this queue is designed for serial io calls
@property(nonatomic, readonly) dispatch_queue_t IOQueue;

+ (PLAppShared *)instance;

@end
