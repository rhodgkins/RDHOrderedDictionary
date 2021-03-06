//
//  RDHMutableOrderedDictionary.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHOrderedDictionary_RDHInternal.h"

@implementation RDHMutableOrderedDictionary

#pragma mark - Immutable Methods

+(instancetype)dictionaryWithCapacity:(NSUInteger)numItems
{
    return [[self alloc] initWithCapacity:numItems];
}

// Designated initialiser
-(instancetype)initWithOrderedDictionary:(RDHOrderedDictionary *)dictionary
{
    self = [super initWithOrderedDictionary:dictionary];
    if (self) {
        _reordersWhenInsertingAlreadyPresentKeys = YES;
    }
    return self;
}

// Designated initialiser
-(instancetype)init
{
    return [self initWithCapacity:0];
}

// Designated initialiser
-(instancetype)initWithCapacity:(NSUInteger)numItems
{
    self = [super init];
    if (self) {
        _reordersWhenInsertingAlreadyPresentKeys = YES;
        orderedKeySet = [NSMutableOrderedSet orderedSetWithCapacity:numItems];
        backingDictionary = [NSMutableDictionary dictionaryWithCapacity:numItems];
    }
    return self;
}

// Designated initialiser
-(instancetype)initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    self = [super initWithObjects:objects forKeys:keys count:cnt];
    if (self) {
        _reordersWhenInsertingAlreadyPresentKeys = YES;
    }
    return self;
}

-(NSEnumerator *)keyEnumerator
{
    return [orderedKeySet objectEnumerator];
}

#pragma mark - Mutable methods

-(void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    NSUInteger currentIndex = [orderedKeySet indexOfObject:aKey];
    
    if (self.reordersWhenInsertingAlreadyPresentKeys) {
        // Remove the current object if needed
        if (currentIndex != NSNotFound) {
            [orderedKeySet removeObject:aKey];
        }
        // Add it to the end
        [orderedKeySet addObject:aKey];
    } else {
        
        if (currentIndex == NSNotFound) {
            // Object was never present so just add it at the end
            [orderedKeySet addObject:aKey];
        } else {
            // Replace the object
            [orderedKeySet replaceObjectAtIndex:currentIndex withObject:aKey];
        }
    }
    
    [backingDictionary setObject:anObject forKey:aKey];
}

-(void)removeObjectForKey:(id)aKey
{
    [orderedKeySet removeObject:aKey];
    
    [backingDictionary removeObjectForKey:aKey];
}

@end
