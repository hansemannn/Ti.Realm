/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiRealmModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiRealmObjectProxy.h"
#import <Realm/Realm.h>

@implementation TiRealmModule

#pragma mark Internal

-(id)moduleGUID
{
	return @"a23aa324-9093-464d-8c9d-bc6d0efdeb8a";
}

-(NSString*)moduleId
{
	return @"ti.realm";
}

#pragma mark Lifecycle

-(void)startup
{
	[super startup];

	NSLog(@"[DEBUG] %@ loaded",self);
}

- (TiRealmObjectProxy*)createObject:(id)args
{
    ENSURE_ARG_COUNT(args, 2);
    
    NSString *name;
    NSDictionary *attributes;
    
    ENSURE_ARG_AT_INDEX(name, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(attributes, args, 1, NSDictionary);
    
    return [[TiRealmObjectProxy alloc] _initWithPageContext:[self pageContext] andName:name attributes:attributes];
}

#pragma Public APIs

- (void)configure:(id)args
{
    [[RLMRealmConfiguration defaultConfiguration] setSchemaVersion:[NSNumber numberWithUnsignedLongLong:NUMLONG([args objectForKey:@"schemaVersion"])]];
    [[RLMRealmConfiguration defaultConfiguration] setReadOnly:[TiUtils boolValue:@"readonly" properties:args def:NO]];
    [[RLMRealmConfiguration defaultConfiguration] setFileURL:[TiUtils toURL:[args objectForKey:@"fileURL"] proxy:self]];
    [[RLMRealmConfiguration defaultConfiguration] setInMemoryIdentifier:[TiUtils stringValue:@"inMemoryIdentifier" properties:args]];
    [[RLMRealmConfiguration defaultConfiguration] setDeleteRealmIfMigrationNeeded:[TiUtils boolValue:@"deleteRealmIfMigrationNeeded" properties:args def:NO]];
}

- (void)invalidate:(id)unused
{
    [[RLMRealm defaultRealm] invalidate];
}

- (id)autorefresh
{
    return NUMBOOL([[RLMRealm defaultRealm] autorefresh]);
}

- (void)setAutorefresh:(id)value
{
    [[RLMRealm defaultRealm] setAutorefresh:[TiUtils boolValue:value def:YES]];
}

// TODO: For some reason, calling this method from the frontend will
// result in deallocated `RLRealm` instances, causing a write error.
- (void)beginWriteTransaction:(id)unused
{
    [[RLMRealm defaultRealm] beginWriteTransaction];
}

// TODO: For some reason, calling this method from the frontend will
// result in deallocated `RLRealm` instances, causing a write error.
- (void)commitWriteTransaction:(id)unused
{
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

// TODO: For some reason, calling this method from the frontend will
// result in deallocated `RLRealm` instances, causing a write error.
- (void)canceltWriteTransaction:(id)unused
{
    [[RLMRealm defaultRealm] cancelWriteTransaction];
}

- (void)addObject:(id)value
{
    ENSURE_SINGLE_ARG(value, TiRealmObjectProxy);
    
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] addObject:[(TiRealmObjectProxy*)value object]];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)addObjects:(id)args
{
    ENSURE_SINGLE_ARG(args, NSArray);
    NSMutableArray *objects = [NSMutableArray arrayWithArray:@[]];
    
    for (id object in args) {
        ENSURE_TYPE(object, TiRealmObjectProxy);
        [objects addObject:[(TiRealmObjectProxy*)object object]];
    }
    
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] addObjects:objects];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)addOrUpdateObject:(id)value
{
    ENSURE_SINGLE_ARG(value, TiRealmObjectProxy);
    
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] addOrUpdateObject:[(TiRealmObjectProxy*)value object]];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)addOrUpdateObjectFromArray:(id)args
{
    ENSURE_SINGLE_ARG(args, NSArray);
    NSMutableArray *objects = [NSMutableArray arrayWithArray:@[]];
    
    for (id object in args) {
        ENSURE_TYPE(object, TiRealmObjectProxy);
        [objects addObject:[(TiRealmObjectProxy*)object object]];
    }
    
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] addOrUpdateObjectsFromArray:objects];
}

- (void)deleteObject:(id)value
{
    ENSURE_SINGLE_ARG(value, TiRealmObjectProxy);
    
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] deleteObject:[(TiRealmObjectProxy*)value object]];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)deleteObjects:(id)args
{
    ENSURE_SINGLE_ARG(args, NSArray);
    NSMutableArray *objects = [NSMutableArray arrayWithArray:@[]];
    
    for (id object in args) {
        ENSURE_TYPE(object, TiRealmObjectProxy);
        [objects addObject:[(TiRealmObjectProxy*)object object]];
    }
    
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] deleteObjects:objects];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)deleteAllObjects:(id)unused
{
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] deleteAllObjects];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (id)objectClasses
{
    return [[RLMRealmConfiguration defaultConfiguration] objectClasses] ?: @[];
}

@end
