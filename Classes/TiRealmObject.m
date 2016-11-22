/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiRealmObject.h"
#include "TiUtils.h"

@implementation TiRealmObject

- (RLMObject*)object
{
    if (!object) {
        object = [[RLMObject alloc] initWithValue:[self valueForKey:@"value"]];
    }
    
    return object;
}

- (id)get:(id)value
{
    return [[self object] objectForKeyedSubscript:[TiUtils stringValue:value]];
}

- (void)set:(id)args
{
    ENSURE_ARG_COUNT(args, 2);
    
    NSString *key = [args objectAtIndex:0];
    id value = [args objectAtIndex:1];
    
    [[self object] setObject:value forKeyedSubscript:key];
}

- (id)isInvalidated:(id)unused
{
    return NUMBOOL([[self object] isInvalidated]);
}

- (id)indexedProperties
{
    return [RLMObject indexedProperties];
}

@end
