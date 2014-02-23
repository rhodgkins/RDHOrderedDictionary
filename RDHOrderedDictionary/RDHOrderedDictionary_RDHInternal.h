//
//  RDHOrderedDictionary_RDHInternal.h
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHOrderedDictionary.h"

FOUNDATION_EXPORT NSMutableOrderedSet* NSMutableOrderedSetFromObjectsPreservingOrder(const id<NSCopying> objects[], NSUInteger cnt);

@interface RDHOrderedDictionary ()
{
@private
    NSOrderedSet *orderedKeySet;
    NSDictionary *backingDictionary;
}

@end

@interface RDHMutableOrderedDictionary ()
{
@private
    NSMutableOrderedSet *orderedKeySet;
    NSMutableDictionary *backingDictionary;
}

@end