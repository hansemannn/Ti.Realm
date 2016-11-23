/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiRealmObjectProxy.h"
#import "TiRealmObject.h"
#import "TiUtils.h"
#import <objc/runtime.h>

@implementation TiRealmObjectProxy

#pragma mark Internal APIs

- (id)_initWithPageContext:(id<TiEvaluator>)context andName:(NSString*)name attributes:(NSDictionary*)attributes
{
    // TODO: Map types to Realm constants
    
    if (self = [super _initWithPageContext:context]) {
        [TiRealmObjectProxy manipulateClassWithAttributes:attributes];
        [self setObject:[[TiRealmObject alloc] init]];
    }
    
    return self;
}
    
+ (void)manipulateClassWithAttributes:(NSDictionary*)attributes
{
        for (NSString* key in attributes) {
            objc_property_attribute_t type = { "T", [[NSString stringWithFormat:@"@\"%@\"",[attributes valueForKey:key]] UTF8String] };
            objc_property_attribute_t backingivar  = { "V", "_privateName" };
            objc_property_attribute_t attrs[] = { type, backingivar };
            
            class_addProperty([TiRealmObject class], [key UTF8String], attrs, 2);
            class_addMethod([TiRealmObject class], NSSelectorFromString(key), (IMP)nameGetter, "@@:");
            class_addMethod([TiRealmObject class], NSSelectorFromString([NSString stringWithFormat:@"%@:", key]), (IMP)nameSetter, "v@:@");
        }
}

NSString *nameGetter(id self, SEL _cmd) {
    Ivar ivar = class_getInstanceVariable([TiRealmObject class], "_privateName");
    return object_getIvar(self, ivar);
}

void nameSetter(id self, SEL _cmd, NSString *newName) {
    Ivar ivar = class_getInstanceVariable([TiRealmObject class], "_privateName");
    id oldName = object_getIvar(self, ivar);
    if (oldName != newName) object_setIvar(self, ivar, [newName copy]);
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
