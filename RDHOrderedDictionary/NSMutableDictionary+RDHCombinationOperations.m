//
//  NSMutableDictionary+RDHCombinationOperations.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 24/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "NSMutableDictionary+RDHCombinationOperations.h"

@implementation NSMutableDictionary (RDHCombinationOperations)

-(void)intersectIgnoringValuesFromDictionary:(NSDictionary *)dictionary
{
    // First get all the keys
    NSMutableArray *missingKeys = [[self allKeys] mutableCopy];
    
    // Now remove all keys that are present in the provided dictionary
    [missingKeys removeObjectsInArray:[dictionary allKeys]];
    
    // We're now left with a set of keys from the receiver that don't exist in the provided dictionary
    [self removeObjectsForKeys:missingKeys];
}

-(void)intersectReplacingValuesFromDictionary:(NSDictionary *)dictionary
{
    // First get all the keys
    NSMutableArray *missingKeys = [[self allKeys] mutableCopy];
    
    // Now remove all keys that are present in the provided dictionary
    [missingKeys removeObjectsInArray:[dictionary allKeys]];
    
    // We're now left with a set of keys from the receiver that don't exist in the provided dictionary
    [self removeObjectsForKeys:missingKeys];
    
    // Now add the needed objects
    for (id key in [self allKeys]) {
        [self setObject:[dictionary objectForKey:key] forKey:key];
    }
}

-(void)minusDictionary:(NSDictionary *)dictionary
{
    [self removeObjectsForKeys:[dictionary allKeys]];
}

-(void)unionDictionary:(NSDictionary *)dictionary
{
    [self addEntriesFromDictionary:dictionary];
}

@end
