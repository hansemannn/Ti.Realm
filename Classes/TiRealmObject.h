/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiProxy.h"
#import <Realm/Realm.h>

@interface TiRealmObject : TiProxy {
    RLMObject *object;
}

- (RLMObject*)object;

- (id)isInvalidated:(id)unused;

- (id)indexedProperties;

@end
