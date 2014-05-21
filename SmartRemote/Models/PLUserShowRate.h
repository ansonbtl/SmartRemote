//
//  PLUserShowRate.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PLUserShowRate : NSManagedObject

@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSString * seriesID;
@property (nonatomic, retain) NSString * showIDs;
@property (nonatomic, retain) NSString * showIDsExtra;
@property (nonatomic, retain) NSString * showName;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSNumber * hidden;
@property (nonatomic, retain) NSNumber * guiltyPleaesure;
@property (nonatomic, retain) NSString * userID;

@end
