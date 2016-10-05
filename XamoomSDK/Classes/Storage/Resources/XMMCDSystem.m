//
//  XMMCDSystem.m
//  XamoomSDK
//
//  Created by Raphael Seher on 05/10/2016.
//  Copyright © 2016 xamoom GmbH. All rights reserved.
//

#import "XMMCDSystem.h"

@implementation XMMCDSystem

@dynamic jsonID;
@dynamic name;
@dynamic url;
@dynamic setting;
@dynamic style;
@dynamic menu;

+ (NSString *)coreDataEntityName {
  return NSStringFromClass([self class]);
}

+ (instancetype)insertNewObjectFrom:(id)entity {
  XMMSystem *system = (XMMSystem *)entity;
  XMMCDSystem *savedSystem = nil;
  
  // check if object already exists
  NSArray *objects = [[XMMOfflineStorageManager sharedInstance] fetch:[[self class] coreDataEntityName]
                                                               jsonID:system.ID];
  if (objects.count > 0) {
    savedSystem = objects.firstObject;
  } else {
    savedSystem = [NSEntityDescription insertNewObjectForEntityForName:[[self class] coreDataEntityName]
                                                inManagedObjectContext:[XMMOfflineStorageManager sharedInstance].managedObjectContext];
  }
  
  savedSystem.jsonID = system.ID;
  savedSystem.name = system.name;
  savedSystem.url = system.url;
  
  [[XMMOfflineStorageManager sharedInstance] save];
  
  return savedSystem;
}

@end
