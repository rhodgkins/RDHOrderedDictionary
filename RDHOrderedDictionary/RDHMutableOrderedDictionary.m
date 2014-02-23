//
//  RDHMutableOrderedDictionary.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHOrderedDictionary.h"

@implementation RDHMutableOrderedDictionary
{
    NSMutableOrderedSet *orderedKeySet;
    NSMutableDictionary *backingDictionary;
}

#pragma mark - Immutable Methods

-(instancetype)init
{
    return [self initWithCapacity:0];
}

-(instancetype)initWithCapacity:(NSUInteger)numItems
{
    self = [super init];
    if (self) {
        orderedKeySet = [NSMutableOrderedSet orderedSetWithCapacity:numItems];
        backingDictionary = [NSMutableDictionary dictionaryWithCapacity:numItems];
    }
    return self;
}

-(instancetype)initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    self = [super init];
    if (self) {
        orderedKeySet = [NSMutableOrderedSet orderedSetWithObjects:keys count:cnt];
        backingDictionary = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys count:cnt];
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

#pragma mark - Mutable methods

-(void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    [orderedKeySet removeObject:aKey];
    [orderedKeySet addObject:aKey];
    
    [backingDictionary setObject:anObject forKey:aKey];
}

-(void)removeObjectForKey:(id)aKey
{
    [orderedKeySet removeObject:aKey];
    
    [backingDictionary removeObjectForKey:aKey];
}

@end
