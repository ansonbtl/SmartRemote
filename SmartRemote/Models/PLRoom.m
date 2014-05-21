//
//  PLRoom.m
//  SmartRemote
//
//  Created by Anson Li on 5/20/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLRoom.h"
#import "PLDataManager.h"
#import "PLUtility.h"

@implementation PLRoom

@dynamic uniqueID;
@dynamic roomID;
@dynamic name;
@dynamic providerID;
@dynamic createdAt;
@dynamic userID;

+ (PLRoom *)newRoom {
    return [self newRoomWithContext:[PLDataManager instance].dataContext];
}

+ (PLRoom *)newRoomWithContext:(NSManagedObjectContext *)context {
    PLRoom *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:context];
    
    room.createdAt = [NSDate date];
    room.roomID = [NSNumber numberWithInteger:[[PLDataManager instance] newRoomID]];
    room.uniqueID = [PLUtility UUID];
    
    return room;
}

@end
