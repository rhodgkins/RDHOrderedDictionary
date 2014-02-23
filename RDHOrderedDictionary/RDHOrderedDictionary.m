//
//  RDHOrderedDictionary.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHOrderedDictionary_RDHInternal.h"

@implementation RDHOrderedDictionary

#pragma mark - Immutable Methods

-(instancetype)init
{
    self = [super init];
    if (self) {
        orderedKeySet = [NSOrderedSet orderedSet];
        backingDictionary = [NSDictionary dictionary];
    }
    return self;
}

-(instancetype)initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    self = [super init];
    if (self) {
        orderedKeySet = [NSMutableOrderedSetFromObjectsPreservingOrder(keys, cnt) copy];
        backingDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    return self;
}

-(NSUInteger)count
{
    return [orderedKeySet count];
}

-(id)objectForKey:(id)aKey
{
    return [backingDictionary objectForKey:aKey];
}

-(NSEnumerator *)keyEnumerator
{
    return [orderedKeySet objectEnumerator];
}

@end
