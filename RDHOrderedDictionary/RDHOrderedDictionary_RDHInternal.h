//
//  RDHOrderedDictionary_RDHInternal.h
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHOrderedDictionary.h"

FOUNDATION_EXPORT __nonnull NSMutableOrderedSet<id<NSCopying>>* NSMutableOrderedSetFromObjectsPreservingOrder(const id<NSCopying> __nonnull objects[], NSUInteger cnt);

@interface RDHOrderedDictionary<KeyType, ObjectType> ()
{
@package
    NSMutableOrderedSet<KeyType> *__nonnull orderedKeySet;
    NSMutableDictionary<KeyType, ObjectType> *__nonnull backingDictionary;
}

@end

@interface RDHMutableOrderedDictionary<KeyType, ObjectType> ()

@end