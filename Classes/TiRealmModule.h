/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiModule.h"

@interface TiRealmModule : TiModule

- (void)configure:(id)args;

- (void)invalidate:(id)unused;

- (id)autorefresh;

- (void)setAutorefresh:(id)value;

- (void)beginWriteTransaction:(id)unused;

- (void)commitWriteTransaction:(id)unused;

- (void)canceltWriteTransaction:(id)unused;

- (void)addObject:(id)value;

- (void)addObjects:(id)args;

- (void)addOrUpdateObject:(id)value;

- (void)addOrUpdateObjectFromArray:(id)args;

- (void)deleteObject:(id)value;

- (void)deleteObjects:(id)args;

- (void)deleteAllObjects:(id)unused;

- (id)objectClasses;

@end
