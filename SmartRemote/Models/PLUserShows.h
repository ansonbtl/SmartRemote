//
//  PLUserShows.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PLUserShows : NSManagedObject

@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSString * showName;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSNumber * hidden;
@property (nonatomic, retain) NSNumber * guiltyPleasure;
@property (nonatomic, retain) NSString * altName;
@property (nonatomic, retain) NSString * userID;

@end
