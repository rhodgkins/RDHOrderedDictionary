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

-(BOOL)isEqualToOrderedDictionary:(RDHOrderedDictionary *)otherDictionary;

@end

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
-(void)setObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end

@interface RDHMutableOrderedDictionary (RDHExtendedMutableOrderedDictionary)

/// @name Adding and removing objects

-(void)addEntriesFromDictionary:(NSDictionary *)otherDictionary;
-(void)removeAllObjects;
-(void)removeObjectsForKeys:(NSArray *)keyArray;
-(void)setDictionary:(NSDictionary *)otherDictionary;
-(void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key NS_AVAILABLE(10_8, 6_0);

@end