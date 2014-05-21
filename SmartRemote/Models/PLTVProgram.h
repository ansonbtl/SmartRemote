//
//  PLTVProgram.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PLTVProgram : NSManagedObject

@property (nonatomic, retain) NSString * roomID;
@property (nonatomic, retain) NSString * channelCode;
@property (nonatomic, retain) NSString * channelNumber;
@property (nonatomic, retain) NSString * duration;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSString * episodeID;
@property (nonatomic, retain) NSString * episodeTitile;
@property (nonatomic, retain) NSDate * eventDate;
@property (nonatomic, retain) NSDate * eventTime;
@property (nonatomic, retain) NSString * genre;
@property (nonatomic, retain) NSNumber * hd;
@property (nonatomic, retain) NSDate * origAirDate;
@property (nonatomic, retain) NSString * programDescription;
@property (nonatomic, retain) NSString * programImageURI;
@property (nonatomic, retain) NSString * programType;
@property (nonatomic, retain) NSNumber * rankWeight;
@property (nonatomic, retain) NSString * showName;
@property (nonatomic, retain) NSNumber * showTag;
@property (nonatomic, retain) NSString * teams;
@property (nonatomic, retain) NSString * tmsID;
@property (nonatomic, retain) NSNumber * reminder;
@property (nonatomic, retain) NSString * starring;
@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSString * userID;

@end
