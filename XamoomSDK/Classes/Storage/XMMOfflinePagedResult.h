//
// Copyright (c) 2017 xamoom GmbH <apps@xamoom.com>
//
// Licensed under the MIT License (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at the root of this project.


#import <UIKit/UIKit.h>

@interface XMMOfflinePagedResult : NSObject

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *cursor;
@property (nonatomic, assign) bool hasMore;

@end
