//
//  RDHOrderedDictionary+RDHOrderedExtensions.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHOrderedDictionary_RDHInternal.h"

@implementation RDHOrderedDictionary (RDHOrderedExtensions)

#pragma mark - Accessing Dictionary Members

-(id)firstKey
{
    return [orderedKeySet firstObject];
}

-(id)firstValue
{
    return [self objectForKey:[self firstKey]];
}

-(id)lastKey
{
    return [orderedKeySet lastObject];
}

-(id)lastValue
{
    return [self objectForKey:[self lastKey]];
}

-(NSEnumerator *)reverseKeyEnumerator
{
    return [[orderedKeySet copy] reverseObjectEnumerator];
}

@end
