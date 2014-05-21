//
//  PLRoom.h
//  SmartRemote
//
//  Created by Anson Li on 5/20/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PLRoom : NSManagedObject

@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSNumber * roomID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * providerID;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSDate * createdAt;

+ (PLRoom *)newRoom;
+ (PLRoom *)newRoomWithContext:(NSManagedObjectContext *)context;

@end
