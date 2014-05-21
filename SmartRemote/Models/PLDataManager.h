//
//  PLDataManager.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLRoom.h"
@import CoreData;

@interface PLDataManager : NSObject <NSFetchedResultsControllerDelegate> {
    NSManagedObjectModel *_dataModel;
    NSManagedObjectContext *_dataContext;
    NSPersistentStoreCoordinator *_psc;
}

@property (nonatomic, strong, readonly) NSManagedObjectModel *dataModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *dataContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSFetchedResultsController *fetchedController;

+ (PLDataManager *)instance;

- (void)saveData;

- (NSInteger)newRoomID;

- (NSString *)pathOfImageCacheWithUrl:(NSString *)imageUrl;

@end
