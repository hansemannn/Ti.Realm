/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiProxy.h"
#import <Realm/Realm.h>

@interface TiRealmObject : RLMObject

// TODO: This should be constructed using reflection
@property NSString *firstName;

@end
