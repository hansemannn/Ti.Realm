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
#import "TiRealmObject.h"
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

- (void)beginWriteTransaction:(id)unused
{
    [[RLMRealm defaultRealm] beginWriteTransaction];
}

- (void)commitWriteTransaction:(id)unused
{
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)canceltWriteTransaction:(id)unused
{
    [[RLMRealm defaultRealm] cancelWriteTransaction];
}

- (void)addObject:(id)value
{
    ENSURE_SINGLE_ARG(value, TiRealmObject);
    
    [[RLMRealm defaultRealm] addObject:[(TiRealmObject*)value object]];
}

- (void)addObjects:(id)args
{
    ENSURE_SINGLE_ARG(args, NSArray);
    NSMutableArray *objects = [NSMutableArray arrayWithArray:@[]];
    
    for (id object in args) {
        ENSURE_TYPE(object, TiRealmObject);
        [objects addObject:[(TiRealmObject*)object object]];
    }
    
    [[RLMRealm defaultRealm] addObjects:objects];
}

- (void)addOrUpdateObject:(id)value
{
    ENSURE_SINGLE_ARG(value, TiRealmObject);
    
    [[RLMRealm defaultRealm] addOrUpdateObject:[(TiRealmObject*)value object]];
}

- (void)addOrUpdateObjectFromArray:(id)args
{
    ENSURE_SINGLE_ARG(args, NSArray);
    NSMutableArray *objects = [NSMutableArray arrayWithArray:@[]];
    
    for (id object in args) {
        ENSURE_TYPE(object, TiRealmObject);
        [objects addObject:[(TiRealmObject*)object object]];
    }
    
    [[RLMRealm defaultRealm] addOrUpdateObjectsFromArray:objects];
}

- (void)deleteObject:(id)value
{
    ENSURE_SINGLE_ARG(value, TiRealmObject);
    
    [[RLMRealm defaultRealm] deleteObject:[(TiRealmObject*)value object]];
}

- (void)deleteObjects:(id)args
{
    ENSURE_SINGLE_ARG(args, NSArray);
    NSMutableArray *objects = [NSMutableArray arrayWithArray:@[]];
    
    for (id object in args) {
        ENSURE_TYPE(object, TiRealmObject);
        [objects addObject:[(TiRealmObject*)object object]];
    }
    
    [[RLMRealm defaultRealm] deleteObjects:objects];
}

- (void)deleteAllObjects:(id)unused
{
    [[RLMRealm defaultRealm] deleteAllObjects];
}

- (id)objectClasses
{
    return [[RLMRealmConfiguration defaultConfiguration] objectClasses] ?: @[];
}

@end
