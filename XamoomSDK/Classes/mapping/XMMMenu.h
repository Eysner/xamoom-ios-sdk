//
// Copyright (c) 2017 xamoom GmbH <apps@xamoom.com>
//
// Licensed under the MIT License (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at the root of this project.


#import <Foundation/Foundation.h>
#import <JSONAPI/JSONAPIResourceBase.h>
#import <JSONAPI/JSONAPIResourceDescriptor.h>
#import <JSONAPI/JSONAPIPropertyDescriptor.h>
#import "XMMRestResource.h"

/**
 * XMMMenu with the menuItems.
 */
@interface XMMMenu : JSONAPIResourceBase  <XMMRestResource>

/**
 * XMMMenuItem as array.
 */
@property (strong, nonatomic) NSArray *items;

@end
