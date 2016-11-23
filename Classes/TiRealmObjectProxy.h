/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import <Realm/Realm.h>

@interface TiRealmObjectProxy : TiProxy

@property(nonatomic, retain) RLMObject* object;

#pragma mark Internal APIs

/**
 @discussion Creates a new `TiRealmObjectProxy` instance by proving a name
 and attributes.
 
 @param context The current evaluation context
 @param name The name of the object
 @param attributes The attributes of the object
 */
- (id)_initWithPageContext:(id<TiEvaluator>)context andName:(NSString*)name attributes:(NSDictionary*)attributes;

#pragma mark Public APIs
 
/**
 @discussion Returns the value of a Realm object.
 
 @param value The key of the object
 @return The value of the object
 */
- (id)getProperty:(id)value;

/**
 @discussion Saves the value of a Realm object.
 
 @param args The key and value of the object
 */
- (void)setProperty:(id)args;

@end
