//
//  RDHOrderedDictionary.h
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDHOrderedDictionary : NSDictionary

/// @name Creating and Initializing a Dictionary

+(instancetype)dictionaryWithOrderedDictionary:(RDHOrderedDictionary *)dictionary;

-(instancetype)initWithOrderedDictionary:(RDHOrderedDictionary *)dictionary;

#pragma mark - Comparing Dictionaries
/// @name Comparing Dictionaries

/// This only compares the contents and not the ordering use `-isEqualToOrderedDictionary:` to check the ordering.
-(BOOL)isEqualToDictionary:(NSDictionary *)otherDictionary;

-(BOOL)isEqualToOrderedDictionary:(RDHOrderedDictionary *)otherDictionary;

@end

@interface RDHOrderedDictionary (RDHOrderedExtensions)

#pragma mark - Accessing Dictionary Members
/// @name Accessing Dictionary Members

/// @returns the first key in the ordered dictionary.
-(id)firstKey;

/// @returns the value for the first key in the ordered dictionary.
-(id)firstValue;

/// @returns the last key in the ordered dictionary.
-(id)lastKey;

/// @returns the last for the first key in the ordered dictionary.
-(id)lastValue;

/// @returns the reverse of `-keyEnumerator`.
-(NSEnumerator *)reverseKeyEnumerator;

@end

/*******************************************************/
/************	Mutable Ordered Dictionary	************/
/*******************************************************/
#pragma mark - Mutable Ordered Dictionary

@interface RDHMutableOrderedDictionary : RDHOrderedDictionary

/**
 * This specifies that the order of the keys (and therefore their values) are kept as they are added. That is adding the keys [0, 1, 2] and adding 0 will mean the order of the keys is now [1, 2, 0].
 * Setting this to `NO` will mean the order would instead not change as 0 is already present.
 *
 * Defaults to `YES`.
 */
@property (nonatomic) BOOL reordersWhenInsertingAlreadyPresentKeys;

/// @name Creating and Initializing a Mutable Dictionary

+(instancetype)dictionaryWithCapacity:(NSUInteger)numItems;

-(instancetype)init;
-(instancetype)initWithCapacity:(NSUInteger)numItems;

/// @name Adding and removing objects

-(void)removeObjectForKey:(id)aKey;

/// @see `reordersWhenInsertingAlreadyPresentKeys`
-(void)setObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end

@interface RDHMutableOrderedDictionary (RDHExtendedMutableOrderedDictionary)

/// @name Adding and removing objects

/// Adds the entries from the provided dictionary as they are ordered in that dictionary.
-(void)addEntriesFromDictionary:(NSDictionary *)otherDictionary;
-(void)removeAllObjects;
-(void)removeObjectsForKeys:(NSArray *)keyArray;

/// Replaces the contents of this dictionary with the provided one keeping the order as they were ordered in that dictionary.
-(void)setDictionary:(NSDictionary *)otherDictionary;
-(void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

@end

@interface RDHMutableOrderedDictionary (RDHOrderedExtensions)

/// @name Adding and removing objects

/// Removes the `-firstKey` and its value.
-(void)removeFirstEntry;

/// Removes the `-lastKey` and its value.
-(void)removeLastEntry;

/// @name Sorting Entries

/// Sorts the array in place using the provided sort descriptors.
-(void)sortEntriesByKeysUsingDescriptors:(NSArray *)sortDescriptors;

#if NS_BLOCKS_AVAILABLE

/// Sorts the array in place using the provided comparator.
-(void)sortEntriesByKeysUsingComparator:(NSComparator)cmptr;

/// Sorts the array in place using the provided comparator and specified options.
-(void)sortEntriesByKeysWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;

#endif

@end