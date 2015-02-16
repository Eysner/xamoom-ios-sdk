/**
 *
 *  Copyright 2015 by Raphael Seher <raphael@xamoom.com>
 *
 * This file is part of some open source application.
 *
 * Some open source application is free software: you can redistribute
 * it and/or modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation, either
 * version 2 of the License, or (at your option) any later version.
 *
 * Some open source application is distributed in the hope that it will
 * be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with xamoom-ios-sdk. If not, see <http://www.gnu.org/licenses/>.
 *
 */

#import "XMMEnduserApi.h"
#import <RestKit/RestKit.h>

static NSString * const BaseURLString = @"https://xamoom-api-dot-xamoom-cloud-dev.appspot.com/_ah/api/";

@implementation XMMEnduserApi : NSObject

NSURL *baseURL;
RKManagedObjectStore *managedObjectStore;
RKObjectManager *objectManager;
NSArray* articles;

@synthesize delegate;

-(id)init
{
    self = [super init];
    baseURL = [NSURL URLWithString:BaseURLString];
    return self;
}

- (void)getContentById:(NSString*)contentId includeStyle:(NSString*)style includeMenu:(NSString*)menu language:(NSString*)language
{
    NSDictionary *queryParams = @{@"content_id":contentId,
                                  @"include_style":style,
                                  @"include_menu":menu,
                                  @"language":language
                                  };
    
    //mappings
    RKDynamicMapping* dynamicMapping = [RKDynamicMapping new];
    
    RKObjectMapping* responseMapping = [XMMResponseGetById getMapping];
    RKObjectMapping* responseContentMapping = [XMMResponseContent getMapping];
    RKObjectMapping* responseStyleMapping = [XMMResponseStyle getMapping];
    RKObjectMapping* responseMenuMapping = [XMMResponseMenuItem getMapping];
    
    //dynamic matcher
    [dynamicMapping addMatcher:[XMMResponseContentBlockType0 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType1 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType2 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType3 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType4 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType5 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType6 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType7 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType8 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType9 getDynamicMappingMatcher]];
    
    
    //relationships
    [responseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content"
                                                                                    toKeyPath:@"content"
                                                                                  withMapping:responseContentMapping]];
    
    [responseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content.content_blocks"
                                                                                    toKeyPath:@"content.contentBlocks"
                                                                                  withMapping:dynamicMapping]];
    
    [responseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"style"
                                                                                    toKeyPath:@"style"
                                                                                  withMapping:responseStyleMapping]];
    
    [responseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"menu.items"
                                                                                    toKeyPath:@"menu"
                                                                                  withMapping:responseMenuMapping]];
    
    [self talkToApi:responseMapping
     withParameters:queryParams
           withpath:@"xamoomEndUserApi/v1/get_content_by_content_id"];
}

- (void)getContentByLocationIdentifier:(NSString*)locationIdentifier includeStyle:(NSString*)style includeMenu:(NSString*)menu language:(NSString*)language
{
    NSDictionary *queryParams = @{@"location_identifier":locationIdentifier,
                                  @"include_style":style,
                                  @"include_menu":menu,
                                  @"language":language
                                  };
    
    //mappings
    RKDynamicMapping* dynamicMapping = [RKDynamicMapping new];
    
    RKObjectMapping* responseMapping = [XMMResponseGetByLocationIdentifier getMapping];
    RKObjectMapping* responseContentMapping = [XMMResponseContent getMapping];
    RKObjectMapping* responseStyleMapping = [XMMResponseStyle getMapping];
    RKObjectMapping* responseMenuMapping = [XMMResponseMenuItem getMapping];
    
    //dynamic matcher
    [dynamicMapping addMatcher:[XMMResponseContentBlockType0 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType1 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType2 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType3 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType4 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType5 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType6 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType7 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType8 getDynamicMappingMatcher]];
    [dynamicMapping addMatcher:[XMMResponseContentBlockType9 getDynamicMappingMatcher]];
    
    //relationships
    [responseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content"
                                                                                    toKeyPath:@"content"
                                                                                  withMapping:responseContentMapping]];
    
    [responseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content.content_blocks"
                                                                                    toKeyPath:@"content.contentBlocks"
                                                                                  withMapping:dynamicMapping]];
    
    [responseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"style"
                                                                                    toKeyPath:@"style"
                                                                                  withMapping:responseStyleMapping]];
    
    [responseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"menu.items"
                                                                                    toKeyPath:@"menu"
                                                                                  withMapping:responseMenuMapping]];
    
    
    [self talkToApi:responseMapping
     withParameters:queryParams
           withpath:@"xamoomEndUserApi/v1/get_content_by_location_identifier"];
}

- (void)getContentByLocation:(NSString*)lat lon:(NSString*)lon language:(NSString*)language
{
    NSDictionary *queryParams = @{@"location":
                                      @{@"lat":lat,
                                        @"lon":lon,
                                        },
                                  @"language":language,
                                  };
    
    //mappings
    RKObjectMapping* responseMapping = [XMMResponseGetByLocation getMapping];
    RKObjectMapping* responseItemMapping = [XMMResponseGetByLocationItem getMapping];
    
    //relationships
    [responseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"items"
                                                                                    toKeyPath:@"items"
                                                                                  withMapping:responseItemMapping]];
    
    [self talkToApi:responseMapping
     withParameters:queryParams
           withpath:@"xamoomEndUserApi/v1/get_content_by_location"];
    
}

- (void)talkToApi:(RKObjectMapping*)objectMapping withParameters:(NSDictionary*)parameters withpath:(NSString*)path
{
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *contentDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:objectMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:statusCodes];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:baseURL];
    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    
    [manager addResponseDescriptor:contentDescriptor];
    
    [manager postObject:nil path:path parameters:parameters
                success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                    NSLog(@"Output: %@", mappingResult.firstObject);
                    [delegate performSelector:@selector(finishedLoadData:) withObject: mappingResult];
                }
                failure:^(RKObjectRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                }
     ];
}

# pragma mark - Core Data

- (void)initRestkitCoreData
{
    // Initialize RestKit
    objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    // Initialize managed object model from bundle
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    // Initialize managed object store
    managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    
    // Complete Core Data stack initialization
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"XMMCoreData.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    // Enable Activity Indicator Spinner
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

- (void)getContentByIdFromCoreData:(NSString *)contentId includeStyle:(NSString *)style includeMenu:(NSString *)menu language:(NSString *)language
{
    //mapping
    RKDynamicMapping* dynamicMapping = [RKDynamicMapping new];
    
    RKEntityMapping *coreDataMapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataGetById" inManagedObjectStore:managedObjectStore];
    [coreDataMapping addAttributeMappingsFromDictionary:[XMMCoreData getMapping]];
    
    RKEntityMapping *coreDataStyleMapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataStyle" inManagedObjectStore:managedObjectStore];
    [coreDataStyleMapping addAttributeMappingsFromDictionary:[XMMCoreDataStyle getMapping]];
    
    RKEntityMapping *coreDataMenuMapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataMenuItem" inManagedObjectStore:managedObjectStore];
    [coreDataMenuMapping addAttributeMappingsFromDictionary:[XMMCoreDataMenuItem getMapping]];
    
    RKEntityMapping *coreDataContentMapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContent" inManagedObjectStore:managedObjectStore];
    [coreDataContentMapping addAttributeMappingsFromDictionary:[XMMCoreDataContent getMapping]];
    
    RKEntityMapping *coreDataContentBlockType0Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType0" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType0Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType0 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType1Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType1" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType1Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType1 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType2Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType2" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType2Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType2 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType3Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType3" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType3Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType3 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType4Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType4" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType4Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType4 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType5Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType5" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType5Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType5 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType6Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType6" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType6Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType6 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType7Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType7" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType7Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType7 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType8Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType8"  inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType8Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType8 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType9Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType9"  inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType9Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType9 getMapping]];
    
    //dynamic mapping
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"0"
                                                             objectMapping:coreDataContentBlockType0Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"1"
                                                             objectMapping:coreDataContentBlockType1Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"2"
                                                             objectMapping:coreDataContentBlockType2Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"3"
                                                             objectMapping:coreDataContentBlockType3Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"4"
                                                             objectMapping:coreDataContentBlockType4Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"5"
                                                             objectMapping:coreDataContentBlockType5Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"6"
                                                             objectMapping:coreDataContentBlockType6Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"7"
                                                             objectMapping:coreDataContentBlockType7Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"8"
                                                             objectMapping:coreDataContentBlockType8Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"9"
                                                             objectMapping:coreDataContentBlockType9Mapping]];
    
    
    //relationships
    [coreDataMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content"
                                                                                    toKeyPath:@"content"
                                                                                  withMapping:coreDataContentMapping]];
    
    [coreDataMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content.content_blocks"
                                                                                    toKeyPath:@"content.contentBlocks"
                                                                                  withMapping:dynamicMapping]];
    
    [coreDataMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"style"
                                                                                    toKeyPath:@"style"
                                                                                  withMapping:coreDataStyleMapping]];
    
    [coreDataMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"menu.items"
                                                                                    toKeyPath:@"menu"
                                                                                  withMapping:coreDataMenuMapping]];
    
    
    RKResponseDescriptor *coreDataGetByIdResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:coreDataMapping
                                                                                                           method:RKRequestMethodPOST
                                                                                                      pathPattern:nil
                                                                                                          keyPath:nil
                                                                                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
                                                               ];
    
    [objectManager addResponseDescriptor:coreDataGetByIdResponseDescriptor];
    
    NSString *path = @"xamoomEndUserApi/v1/get_content_by_content_id";
    NSDictionary *queryParams = @{@"content_id":contentId,
                                  @"include_style":style,
                                  @"include_menu":menu,
                                  @"language":language,
                                  };
    
    [self talkToApiCoreDataWithParameters:queryParams withpath:path];
}

- (void)getContentByLocationIdentifierFromCoreData:(NSString *)locationIdentifier includeStyle:(NSString *)style includeMenu:(NSString *)menu language:(NSString *)language
{
    
    //mapping
    RKDynamicMapping* dynamicMapping = [RKDynamicMapping new];
    
    RKEntityMapping *coreDataMapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataGetByLocationIdentifier" inManagedObjectStore:managedObjectStore];
    [coreDataMapping addAttributeMappingsFromDictionary:[XMMCoreDataGetByLocationIdentifier getMapping]];
    
    RKEntityMapping *coreDataStyleMapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataStyle" inManagedObjectStore:managedObjectStore];
    [coreDataStyleMapping addAttributeMappingsFromDictionary:[XMMCoreDataStyle getMapping]];
    
    RKEntityMapping *coreDataMenuMapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataMenuItem" inManagedObjectStore:managedObjectStore];
    [coreDataMenuMapping addAttributeMappingsFromDictionary:[XMMCoreDataMenuItem getMapping]];
    
    RKEntityMapping *coreDataContentMapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContent" inManagedObjectStore:managedObjectStore];
    [coreDataContentMapping addAttributeMappingsFromDictionary:[XMMCoreDataContent getMapping]];
    
    RKEntityMapping *coreDataContentBlockType0Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType0" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType0Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType0 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType1Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType1" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType1Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType1 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType2Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType2" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType2Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType2 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType3Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType3" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType3Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType3 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType4Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType4" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType4Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType4 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType5Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType5" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType5Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType5 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType6Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType6" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType6Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType6 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType7Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType7" inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType7Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType7 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType8Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType8"  inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType8Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType8 getMapping]];
    
    RKEntityMapping *coreDataContentBlockType9Mapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataContentBlockType9"  inManagedObjectStore:managedObjectStore];
    [coreDataContentBlockType9Mapping addAttributeMappingsFromDictionary:[XMMCoreDataContentBlockType9 getMapping]];
    
    //dynamic mapping
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"0"
                                                             objectMapping:coreDataContentBlockType0Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"1"
                                                             objectMapping:coreDataContentBlockType1Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"2"
                                                             objectMapping:coreDataContentBlockType2Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"3"
                                                             objectMapping:coreDataContentBlockType3Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"4"
                                                             objectMapping:coreDataContentBlockType4Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"5"
                                                             objectMapping:coreDataContentBlockType5Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"6"
                                                             objectMapping:coreDataContentBlockType6Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"7"
                                                             objectMapping:coreDataContentBlockType7Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"8"
                                                             objectMapping:coreDataContentBlockType8Mapping]];
    
    [dynamicMapping addMatcher: [RKObjectMappingMatcher matcherWithKeyPath:@"content_block_type"
                                                             expectedValue:@"9"
                                                             objectMapping:coreDataContentBlockType9Mapping]];
    
    
    //relationships
    [coreDataMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content"
                                                                                    toKeyPath:@"content"
                                                                                  withMapping:coreDataContentMapping]];
    
    [coreDataMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content.content_blocks"
                                                                                    toKeyPath:@"content.contentBlocks"
                                                                                  withMapping:dynamicMapping]];
    
    [coreDataMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"style"
                                                                                    toKeyPath:@"style"
                                                                                  withMapping:coreDataStyleMapping]];
    
    [coreDataMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"menu.items"
                                                                                    toKeyPath:@"menu"
                                                                                  withMapping:coreDataMenuMapping]];
    
    
    RKResponseDescriptor *coreDataGetByIdResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:coreDataMapping
                                                                                                           method:RKRequestMethodPOST
                                                                                                      pathPattern:nil
                                                                                                          keyPath:nil
                                                                                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
                                                               ];
    
    [objectManager addResponseDescriptor:coreDataGetByIdResponseDescriptor];
    
    NSString *path = @"xamoomEndUserApi/v1/get_content_by_location_identifier";
    NSDictionary *queryParams = @{@"location_identifier":locationIdentifier,
                                  @"include_style":style,
                                  @"include_menu":menu,
                                  @"language":language
                                  };
    
    [self talkToApiCoreDataWithParameters:queryParams withpath:path];
}

- (void)getContentByLocationFromCoreData:(NSString *)lat lon:(NSString *)lon language:(NSString *)language
{
    RKEntityMapping *coreDataMapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataGetByLocation" inManagedObjectStore:managedObjectStore];
    [coreDataMapping addAttributeMappingsFromDictionary:[XMMCoreDataGetByLocation getMapping]];
    
    RKEntityMapping *coreDataItemMapping = [RKEntityMapping mappingForEntityForName:@"XMMCoreDataGetByLocationItem" inManagedObjectStore:managedObjectStore];
    [coreDataItemMapping addAttributeMappingsFromDictionary:[XMMCoreDataGetByLocationItem getMapping]];
    
    //relationships
    [coreDataMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"items"
                                                                                    toKeyPath:@"items"
                                                                                  withMapping:coreDataItemMapping]];
    
    
    RKResponseDescriptor *coreDataGetByIdResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:coreDataMapping
                                                                                                           method:RKRequestMethodPOST
                                                                                                      pathPattern:nil
                                                                                                          keyPath:nil
                                                                                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
                                                               ];
    
    [objectManager addResponseDescriptor:coreDataGetByIdResponseDescriptor];
    
    NSString *path = @"xamoomEndUserApi/v1/get_content_by_location";
    NSDictionary *queryParams = @{@"location":
                                      @{@"lat":lat,
                                        @"lon":lon,
                                        },
                                  @"language":language,
                                  };
    
    [self talkToApiCoreDataWithParameters:queryParams withpath:path];
}

- (void)talkToApiCoreDataWithParameters:(NSDictionary*)parameters withpath:(NSString*)path
{
    [RKObjectManager sharedManager].requestSerializationMIMEType = RKMIMETypeJSON;
    [[RKObjectManager sharedManager] postObject:nil path:path parameters:parameters
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            NSLog(@"Output: %@", mappingResult.firstObject);
                                            [delegate performSelector:@selector(finishedLoadData:) withObject: mappingResult];
                                        }
                                        failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                            NSLog(@"Error: %@", error);
                                        }
     ];
}

- (void)fetchCoreDataContentBy:(NSString *)type {
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    
    NSFetchRequest *fetchRequest;
    
    if ([type.lowercaseString isEqualToString:@"id"]){
        fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"XMMCoreDataGetById"];
    }
    else if ([type.lowercaseString isEqualToString:@"location"]){
        fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"XMMCoreDataGetByLocation"];
    }
    else if ([type.lowercaseString isEqualToString:@"locationIdentifier"]){
        fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"XMMCoreDataGetByLocationIdentifier"];
    }
    else {
        NSLog(@"Type not found.");
    }
    
    //NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    //fetchRequest.sortDescriptors = @[descriptor];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"Output fetch: %@", fetchedObjects.firstObject);
}



@end
