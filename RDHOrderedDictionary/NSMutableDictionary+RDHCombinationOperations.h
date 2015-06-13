//
//  NSMutableDictionary+RDHCombinationOperations.h
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 24/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Combination Operations

@interface NSMutableDictionary<KeyType, ObjectType> (RDHCombinationOperations)

#pragma mark - Combining and Recombining Dictionaries
/// @name Combining and Recombining Dictionaries

/// Keeps only the entries in the receiver where their keys are present in the provided dictionary. The associated values are ignored.
-(void)intersectIgnoringValuesFromDictionary:(nonnull NSDictionary<KeyType, ObjectType> *)dictionary;

/// Keeps only the entries in the receiver where their keys are present in the provided dictionary. The associated values are replaced.
-(void)intersectReplacingValuesFromDictionary:(nonnull NSDictionary<KeyType, ObjectType> *)dictionary;

/// Removes the entries from the receiver where their keys are present in the provided dictionary. This is exactly the same as `[self removeObjectsForKeys:[dictionary allKeys]]`.
-(void)minusDictionary:(nonnull NSDictionary<KeyType, ObjectType> *)dictionary;

/**
 * Adds entries to the receiver from the provided dictionary. This method is the same as `addEntriesFromDictionary:`. 
 * @see -addEntriesFromDictionary:
 */
-(void)unionDictionary:(nonnull NSDictionary<KeyType, ObjectType> *)dictionary;

@end