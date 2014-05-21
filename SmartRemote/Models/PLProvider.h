//
//  PLProvider.h
//  SmartRemote
//
//  Created by Anson Li on 5/20/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PLLineUp.h"

@interface PLProvider : NSManagedObject

@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * boxType;
@property (nonatomic, retain) NSString * channelDifference;
@property (nonatomic, retain) NSString * mso;
@property (nonatomic, retain) NSString * split;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * headEndId;
@property (nonatomic, retain) NSNumber * lineUpCount;
@property (nonatomic, retain) NSDate * createdAt;

+ (PLProvider *)newProvider;
+ (PLProvider *)newProviderWithContext:(NSManagedObjectContext *)context;

- (void)setValuesWithLineUp:(PLLineUp *)lineUp;

@end
