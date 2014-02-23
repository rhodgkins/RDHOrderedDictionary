//
//  RDHMutableOrderedDictionary+RDHOrderedExtensions.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHOrderedDictionary_RDHInternal.h"

@implementation RDHMutableOrderedDictionary (RDHOrderedExtensions)

-(void)removeFirstEntry
{
    [self removeObjectForKey:[self firstKey]];
}

-(void)removeLastEntry
{
    [self removeObjectForKey:[self lastKey]];
}

#pragma mark - Sorting

-(void)sortEntriesByKeysUsingDescriptors:(NSArray *)sortDescriptors
{
    [orderedKeySet sortUsingDescriptors:sortDescriptors];
}

-(void)sortEntriesByKeysUsingComparator:(NSComparator)cmptr
{
    [self sortEntriesByKeysWithOptions:NSSortStable usingComparator:cmptr];
}

-(void)sortEntriesByKeysWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr
{
    [orderedKeySet sortWithOptions:opts usingComparator:cmptr];
}

@end
