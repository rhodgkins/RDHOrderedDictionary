//
//  NSMutableDictionary+RDHCombinationOperations.h
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 24/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Combination Operations

@interface NSMutableDictionary (RDHCombinationOperations)

#pragma mark - Combining and Recombining Dictionaries
/// @name Combining and Recombining Dictionaries

/// Keeps only the entries in the receiver where their keys are present in the provided dictionary. The associated values are ignored.
-(void)intersectIgnoringValuesFromDictionary:(NSDictionary *)dictionary;

/// Keeps only the entries in the receiver where their keys are present in the provided dictionary. The associated values are replaced.
-(void)intersectReplacingValuesFromDictionary:(NSDictionary *)dictionary;

@end