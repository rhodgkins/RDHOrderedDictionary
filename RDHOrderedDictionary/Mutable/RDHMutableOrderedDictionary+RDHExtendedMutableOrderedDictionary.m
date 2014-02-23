//
//  RDHMutableOrderedDictionary+RDHExtendedMutableOrderedDictionary.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHOrderedDictionary_RDHInternal.h"

@implementation RDHMutableOrderedDictionary (RDHExtendedMutableOrderedDictionary)

-(void)addEntriesFromDictionary:(NSDictionary *)otherDictionary
{
    [otherDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self setObject:obj forKey:key];
    }];
}

-(void)removeAllObjects
{
    [self removeObjectsForKeys:[orderedKeySet array]];
}

-(void)removeObjectsForKeys:(NSArray *)keyArray
{
    for (id key in keyArray) {
        [self removeObjectForKey:key];
    }
}

-(void)setDictionary:(NSDictionary *)otherDictionary
{
    [self removeAllObjects];
    [self addEntriesFromDictionary:otherDictionary];
}

-(void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    [self setObject:obj forKey:key];
}

@end
