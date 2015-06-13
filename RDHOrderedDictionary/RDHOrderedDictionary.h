//
//  RDHOrderedDictionary.h
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Immutable Ordered Dictionary

@interface RDHOrderedDictionary<KeyType, ObjectType> : NSDictionary<KeyType, ObjectType>

/// @name Creating and Initializing a Dictionary

+(nonnull instancetype)dictionaryWithOrderedDictionary:(nonnull RDHOrderedDictionary<KeyType, ObjectType> *)dictionary;

-(nonnull instancetype)initWithOrderedDictionary:(nonnull RDHOrderedDictionary<KeyType, ObjectType> *)dictionary;

#pragma mark - Comparing Dictionaries
/// @name Comparing Dictionaries

/// This only compares the contents and not the ordering use `-isEqualToOrderedDictionary:` to check the ordering.
-(BOOL)isEqualToDictionary:(nonnull NSDictionary<KeyType, ObjectType> *)otherDictionary;

/// Calls `isEqualToDictionary:` and then checks the ordering of the keys.
-(BOOL)isEqualToOrderedDictionary:(nonnull RDHOrderedDictionary<KeyType, ObjectType> *)otherDictionary;

@end


#pragma mark - Ordered Extensions

@interface RDHOrderedDictionary<KeyType, ObjectType> (RDHOrderedExtensions)

#pragma mark - Accessing Dictionary Members
/// @name Accessing Dictionary Members

/// @returns the first key in the ordered dictionary.
-(nullable KeyType)firstKey;

/// @returns the value for the first key in the ordered dictionary.
-(nullable ObjectType)firstValue;

/// @returns the last key in the ordered dictionary.
-(nullable KeyType)lastKey;

/// @returns the last for the first key in the ordered dictionary.
-(nullable ObjectType)lastValue;

/// @returns the reverse of `-keyEnumerator`.
-(nonnull NSEnumerator<KeyType> *)reverseKeyEnumerator;

@end


#pragma mark - Mutable Ordered Dictionary

@interface RDHMutableOrderedDictionary<KeyType, ObjectType> : RDHOrderedDictionary<KeyType, ObjectType>

/**
 * This specifies that the order of the keys (and therefore their values) are kept as they are added. That is adding the keys [0, 1, 2] and adding 0 will mean the order of the keys is now [1, 2, 0].
 * Setting this to `NO` will mean the order would instead not change as 0 is already present.
 *
 * Defaults to `YES`.
 */
@property (nonatomic) BOOL reordersWhenInsertingAlreadyPresentKeys;

#pragma mark - Creating and Initializing a Mutable Dictionary
/// @name Creating and Initializing a Mutable Dictionary

+(nonnull instancetype)dictionaryWithCapacity:(NSUInteger)numItems;

-(nonnull instancetype)init;
-(nonnull instancetype)initWithCapacity:(NSUInteger)numItems;

#pragma mark - Adding and removing objects
/// @name Adding and removing objects

-(void)removeObjectForKey:(nonnull KeyType)aKey;

/**
 * @see reordersWhenInsertingAlreadyPresentKeys
 * @warning anObject must not be `nil`.
 */
-(void)setObject:(nonnull ObjectType)anObject forKey:(nonnull KeyType <NSCopying>)aKey;

@end


#pragma mark - Extended Mutable Ordered Dictionary

@interface RDHMutableOrderedDictionary<KeyType, ObjectType> (RDHExtendedMutableOrderedDictionary)

#pragma mark - Adding and removing objects
/// @name Adding and removing objects

/// Adds (or replaces) the entries from the provided dictionary as they are ordered in that dictionary.
-(void)addEntriesFromDictionary:(nonnull NSDictionary<KeyType, ObjectType> *)otherDictionary;

-(void)removeAllObjects;
-(void)removeObjectsForKeys:(nonnull NSArray<KeyType> *)keyArray;
-(void)removeObjectsForKeySet:(nonnull NSSet<KeyType> *)keySet;
-(void)removeObjectsForOrderedKeySet:(nonnull NSOrderedSet<KeyType> *)orderedKeySet;

/// Replaces the entire contents of this dictionary with the provided one keeping the order as they were ordered in that dictionary.
-(void)setDictionary:(nonnull NSDictionary<KeyType, ObjectType> *)otherDictionary;
-(void)setObject:(nullable ObjectType)obj forKeyedSubscript:(nonnull KeyType <NSCopying>)key;

@end


#pragma mark - Mutable Ordered Extensions

@interface RDHMutableOrderedDictionary<KeyType, ObjectType> (RDHMutableOrderedExtensions)

#pragma mark - Adding and removing objects
/// @name Adding and removing objects

/// Removes the `firstKey` and its value.
-(void)removeFirstEntry;

/// Removes the `lastKey` and its value.
-(void)removeLastEntry;

#pragma mark - Sorting Entries
/// @name Sorting Entries

/// Sorts the array in place using the provided sort descriptors.
-(void)sortEntriesByKeysUsingDescriptors:(nonnull NSArray<NSSortDescriptor *> *)sortDescriptors;

#if NS_BLOCKS_AVAILABLE

/// Sorts the array in place using the provided comparator.
-(void)sortEntriesByKeysUsingComparator:(nonnull NSComparator)cmptr;

/// Sorts the array in place using the provided comparator and specified options.
-(void)sortEntriesByKeysWithOptions:(NSSortOptions)opts usingComparator:(nonnull NSComparator)cmptr;

#endif

@end


#pragma mark - Combination Operations

@interface RDHMutableOrderedDictionary<KeyType, ObjectType> (RDHCombinationOperations)

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