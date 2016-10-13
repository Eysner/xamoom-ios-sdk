//
//  XMMOfflineStorageManager.h
//  XamoomSDK
//
//  Created by Raphael Seher on 29/09/2016.
//  Copyright © 2016 xamoom GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface XMMOfflineStorageManager : NSObject

@property NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedInstance;

+ (void)setSharedInstance:(XMMOfflineStorageManager *)offlineStoreManager;

+ (NSURL *)urlForSavedData:(NSString *)urlString;

#pragma mark - CoreData

- (NSError *)save;

- (NSArray *)fetchAll:(NSString *)entityType;

- (NSArray *)fetch:(NSString *)entityType predicate:(NSPredicate *)predicate;

- (NSArray *)fetch:(NSString *)entityType jsonID:(NSString *)jsonID;

- (void)deleteAllEntities;

#pragma mark - File handling

- (void)saveFileFromUrl:(NSString *)urlString completion:(void(^)(NSData *data, NSError *error))completion;

- (NSData *)savedDataFromUrl:(NSString *)urlString error:(NSError **)error;

- (UIImage *)savedImageFromUrl:(NSString *)urlString error:(NSError **)error;

@end
