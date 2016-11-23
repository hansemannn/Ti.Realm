/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiRealmObjectProxy.h"
#import "TiRealmObject.h"
#import "TiUtils.h"

@implementation TiRealmObjectProxy

#pragma mark Internal APIs

- (id)_initWithPageContext:(id<TiEvaluator>)context andName:(NSString*)name attributes:(NSDictionary*)attributes
{
    if (self = [super _initWithPageContext:context]) {
        
        // TODO: Set name of object to the name provided
        // TODO: Hack properties from proxy into object (Reflection?)
        // TODO: Cast attribute values to native ones and assign using `initWithValue:` afterwards
        [self setObject:[[TiRealmObject alloc] init]];
    }
    
    return self;
}

#pragma mark Public APIs

- (id)getProperty:(id)value
{
    ENSURE_SINGLE_ARG(value, NSString);
    
    // TODO: Cast all possible types to Titanium values
    return [[self object] objectForKeyedSubscript:[TiUtils stringValue:value]];
}

- (void)setProperty:(id)args
{
    ENSURE_ARG_COUNT(args, 2);
    
    NSString *key = [args objectAtIndex:0];
    id value = [args objectAtIndex:1];
    NSError *error;
    
    // TODO: Cast all possible types to native values
    
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[self object] setObject:value forKeyedSubscript:key];
    [[RLMRealm defaultRealm] commitWriteTransaction:&error];
    
    if (error) {
        NSLog(@"[ERROR] Could not persist object to Realm: %@", [error localizedDescription]);
    }
}

@end
