//
//  PLProvider.m
//  SmartRemote
//
//  Created by Anson Li on 5/20/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLProvider.h"
#import "PLDataManager.h"
#import "PLUtility.h"

@implementation PLProvider

@dynamic uniqueID;
@dynamic name;
@dynamic boxType;
@dynamic channelDifference;
@dynamic mso;
@dynamic split;
@dynamic type;
@dynamic headEndId;
@dynamic lineUpCount;
@dynamic createdAt;

+ (PLProvider *)newProvider {
    return [self newProviderWithContext:[PLDataManager instance].dataContext];
}

+ (PLProvider *)newProviderWithContext:(NSManagedObjectContext *)context {
    PLProvider *provider = [NSEntityDescription insertNewObjectForEntityForName:@"Provider" inManagedObjectContext:context];
    
    provider.createdAt = [NSDate date];
    provider.uniqueID = [PLUtility UUID];
    
    return provider;
}

- (void)setValuesWithLineUp:(PLLineUp *)lineUp {
    self.name = lineUp.name;
    self.boxType = lineUp.boxType;
    self.channelDifference = lineUp.channelDifference;
    self.mso = lineUp.mso;
    self.split = lineUp.split;
    self.type = lineUp.type;
    self.headEndId = lineUp.headEndId;
    self.lineUpCount = [NSNumber numberWithInteger:lineUp.lineUpCount];
    
}

@end
