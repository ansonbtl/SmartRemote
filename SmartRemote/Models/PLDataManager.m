//
//  PLDataManager.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLDataManager.h"
#import "PLUtility.h"
#import "PLImageCache.h"


@implementation PLDataManager

+ (PLDataManager *)instance {
    static PLDataManager *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[PLDataManager alloc] init];
        
        [instance initData];
    });
    return instance;
}

- (void)initData {
    
}

#pragma mark - room
- (NSInteger)newRoomID {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
    request.fetchLimit = 1;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"roomID" ascending:NO];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSArray *result = [self.dataContext executeFetchRequest:request error:nil];
    
    if (result.count > 0) {
        PLRoom *room = [result firstObject];
        
        return [room.roomID intValue] + 1;
    }
    else return 1;
}

#pragma mark - image caches
- (NSString *)pathOfImageCacheWithUrl:(NSString *)imageUrl {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ImageCache"];
    request.predicate = [NSPredicate predicateWithFormat:@"url == %@", [imageUrl lowercaseString]];
    request.fetchLimit = 1;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSArray *result = [self.dataContext executeFetchRequest:request error:nil];
    
    if (result && result.count > 0) {
        PLImageCache *cache = result[0];
        return cache.path;
    }
    else return nil;
}

#pragma mark - core data basic
- (NSManagedObjectContext *)dataContext {
    if (_dataContext) return _dataContext;
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _dataContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_dataContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _dataContext;
}

- (NSManagedObjectModel *)dataModel {
    if (_dataModel) return _dataModel;
    
	NSString *path = [[NSBundle mainBundle] pathForResource:@"SmartRemote" ofType:@"momd"];
    NSURL *momURL = [NSURL fileURLWithPath:path];
    _dataModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
	
    return _dataModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_psc) return _psc;
	
    // where to store sqlite database
	NSString *storePath = [PLUtility docDirecotryPath:@"Data"];
    NSString *filePath = [storePath stringByAppendingPathComponent:@"SmartRemote"];
    
	// If the expected store doesn't exist, copy the default store.
	NSURL *storeUrl = [self storeURLWithPath:filePath withPath:storePath];
    
    NSError *err;
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
	
    _psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self dataModel]];
    if (![_psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&err]) {
		NSLog(@"Unresolved error %@, %@", err, [err userInfo]);
		abort();
    }
	
    return _psc;
}

- (NSURL *)storeURLWithPath:(NSString *)filePath withPath:(NSString *)storePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *err;
	if (![fileManager fileExistsAtPath:storePath]) {
		[[NSFileManager defaultManager] createDirectoryAtPath:storePath withIntermediateDirectories:YES attributes:nil error:&err];
		
		NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"sqlite"];
		if (defaultStorePath) [fileManager copyItemAtPath:defaultStorePath toPath:filePath error:NULL];
	}
	
	NSURL *storeUrl = [NSURL fileURLWithPath:filePath];
	
    return storeUrl;
}


@end
