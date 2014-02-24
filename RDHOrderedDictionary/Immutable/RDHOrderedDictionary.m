//
//  RDHOrderedDictionary.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHOrderedDictionary_RDHInternal.h"

NSMutableOrderedSet* NSMutableOrderedSetFromObjectsPreservingOrder(const id<NSCopying> objects[], NSUInteger cnt)
{
    NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithCapacity:cnt];
    
    for (NSUInteger i=0; i<cnt; i++) {
        id<NSCopying> object = objects[i];
        NSUInteger currentIndex = [set indexOfObject:object];
        
        if (currentIndex != NSNotFound) {
            // Remove old object
            [set removeObjectAtIndex:currentIndex];
        }
        [set addObject:object];
    }
    
    return set;
}

@implementation RDHOrderedDictionary

+(instancetype)dictionaryWithOrderedDictionary:(RDHOrderedDictionary *)dictionary
{
    return [[self alloc] initWithOrderedDictionary:dictionary];
}

// Designated initialiser
-(instancetype)initWithOrderedDictionary:(RDHOrderedDictionary *)dictionary
{
    self = [super init];
    if (self) {
        orderedKeySet = [dictionary->orderedKeySet mutableCopy];
        backingDictionary = [dictionary->backingDictionary mutableCopy];
    }
    return self;
}

#pragma mark - Immutable Methods

// Designated initialiser
-(instancetype)init
{
    self = [super init];
    if (self) {
        orderedKeySet = [NSMutableOrderedSet orderedSet];
        backingDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

// Designated initialiser
-(instancetype)initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    self = [super init];
    if (self) {
        orderedKeySet = NSMutableOrderedSetFromObjectsPreservingOrder(keys, cnt);
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
    return [[orderedKeySet copy] objectEnumerator];
}

#pragma mark - Comparison methods

-(BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[RDHOrderedDictionary class]]) {
        return NO;
    }
    return [self isEqualToOrderedDictionary:object];
}

-(BOOL)isEqualToDictionary:(NSDictionary *)otherDictionary
{
    if ([otherDictionary isKindOfClass:[RDHOrderedDictionary class]]) {
        return [self isEqualToOrderedDictionary:(id) otherDictionary];
    }
    return [super isEqualToDictionary:otherDictionary];
}

-(BOOL)isEqualToOrderedDictionary:(RDHOrderedDictionary *)otherDictionary
{
    if (![otherDictionary isKindOfClass:[RDHOrderedDictionary class]]) {
        return NO;
    }
    // Check the contents
    if (![super isEqualToDictionary:otherDictionary]) {
        return NO;
    }
    // Now check the keys are in the same order
    return [orderedKeySet isEqualToOrderedSet:otherDictionary->orderedKeySet];
}

#pragma mark - Copying

-(id)copyWithZone:(NSZone *)zone
{
    return [[RDHOrderedDictionary allocWithZone:zone] initWithOrderedDictionary:self];
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return [[RDHMutableOrderedDictionary allocWithZone:zone] initWithOrderedDictionary:self];
}

#pragma mark - Methods that can use reverse enumeration

#if NS_BLOCKS_AVAILABLE

-(void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block
{
    NSAssert(block, @"block cannot be nil");
    
    [orderedKeySet enumerateObjectsWithOptions:opts usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        return block(obj, [backingDictionary objectForKey:obj], stop);
    }];
}

-(NSSet *)keysOfEntriesWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id key, id obj, BOOL *stop))predicate
{
    NSAssert(predicate, @"predicate cannot be nil");
    
    NSIndexSet *entryIndexes = [orderedKeySet indexesOfObjectsWithOptions:opts passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return predicate(obj, [backingDictionary objectForKey:obj], stop);
    }];
    return [NSSet setWithArray:[orderedKeySet objectsAtIndexes:entryIndexes]];
}

#endif

@end
