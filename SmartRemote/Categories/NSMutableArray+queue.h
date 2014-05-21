//
//  NSMutableArray+queue.h
//  BabyBook
//
//  Created by Anson Li on 2/24/14.
//  Copyright (c) 2014 Anson Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (queue)

- (id)dequeue;
- (void)enqueue:(id)anObject;

@end
