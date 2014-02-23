//
//  RDHBasicTests.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RDHBasicTests : XCTestCase

@property (nonatomic, copy) NSNumberFormatter *spellOutFormatter;

@end

#import "RDHOrderedDictionary.h"

static NSUInteger const RDHObjectCount = 10000;

@implementation RDHBasicTests

-(void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.spellOutFormatter = [NSNumberFormatter new];
    self.spellOutFormatter.numberStyle = NSNumberFormatterSpellOutStyle;
}

-(void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.spellOutFormatter = nil;
    [super tearDown];
}

-(void)testKeyEnumerator
{
    RDHOrderedDictionary *numberKeysDict = [self filledNumberKeyDictionary];
    RDHOrderedDictionary *stringKeysDict = [self filledStringKeyDictionary];
    
    NSEnumerator *enumerator = [numberKeysDict keyEnumerator];
    [numberKeysDict enumerateKeysAndObjectsWithOptions:0 usingBlock:^(id key, id obj, BOOL *stop) {
        id enumObj = [enumerator nextObject];
        XCTAssertEqualObjects(key, enumObj, @"Key enumerator order differs");
    }];
    
    enumerator = [stringKeysDict keyEnumerator];
    [stringKeysDict enumerateKeysAndObjectsWithOptions:0 usingBlock:^(id key, id obj, BOOL *stop) {
        id enumObj = [enumerator nextObject];
        XCTAssertEqualObjects(key, enumObj, @"Key enumerator order differs");
    }];
}

-(void)testObjectEnumerator
{
    RDHOrderedDictionary *numberKeysDict = [self filledNumberKeyDictionary];
    RDHOrderedDictionary *stringKeysDict = [self filledStringKeyDictionary];
    
    NSEnumerator *enumerator = [numberKeysDict objectEnumerator];
    [numberKeysDict enumerateKeysAndObjectsWithOptions:0 usingBlock:^(id key, id obj, BOOL *stop) {
        id enumObj = [enumerator nextObject];
        XCTAssertEqualObjects(obj, enumObj, @"Object enumerator order differs");
    }];
    
    enumerator = [stringKeysDict objectEnumerator];
    [stringKeysDict enumerateKeysAndObjectsWithOptions:0 usingBlock:^(id key, id obj, BOOL *stop) {
        id enumObj = [enumerator nextObject];
        XCTAssertEqualObjects(obj, enumObj, @"Object enumerator order differs");
    }];
}

-(void)testObjectsForKeys
{
    RDHOrderedDictionary *numberKeysDict = [self filledNumberKeyDictionary];
    RDHOrderedDictionary *stringKeysDict = [self filledStringKeyDictionary];
    
    NSArray *numbers = @[@(2), @(5)];
    NSArray *strings = @[[self.spellOutFormatter stringFromNumber:@(2)], [self.spellOutFormatter stringFromNumber:@(5)]];
    
    XCTAssertEqualObjects([numberKeysDict objectsForKeys:numbers notFoundMarker:[NSNull null]], strings, @"Objects do not match expected objects for keys");
    XCTAssertEqualObjects([stringKeysDict objectsForKeys:strings notFoundMarker:[NSNull null]], numbers, @"Objects do not match expected objects for keys");
}

-(void)testAllKeysAndValues
{
    NSArray *keys = @[@(324349), @(-9324), @(2), @(5), @(123), @(12312)];
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:[keys count]];
    for (NSNumber *k in keys) {
        [objects addObject:[self.spellOutFormatter stringFromNumber:k]];
    }
    
    RDHOrderedDictionary *dict = [RDHOrderedDictionary dictionaryWithObjects:objects forKeys:keys];
    
    XCTAssertEqualObjects([dict allKeys], keys, @"All keys does not match expected keys");
    XCTAssertEqualObjects([dict allValues], objects, @"All values does not match expected values");
}

#pragma mark - Dictionary creation

-(RDHOrderedDictionary *)filledNumberKeyDictionary
{
    return [RDHOrderedDictionary dictionaryWithObjectsAndKeys:
            [self.spellOutFormatter stringFromNumber:@(0)], @(0),
            [self.spellOutFormatter stringFromNumber:@(1)], @(1),
            [self.spellOutFormatter stringFromNumber:@(2)], @(2),
            [self.spellOutFormatter stringFromNumber:@(3)], @(3),
            [self.spellOutFormatter stringFromNumber:@(4)], @(4),
            [self.spellOutFormatter stringFromNumber:@(5)], @(5),
            [self.spellOutFormatter stringFromNumber:@(6)], @(6), nil];
}

-(RDHOrderedDictionary *)filledStringKeyDictionary
{
    return [RDHOrderedDictionary dictionaryWithObjectsAndKeys:
            @(0), [self.spellOutFormatter stringFromNumber:@(0)],
            @(1), [self.spellOutFormatter stringFromNumber:@(1)],
            @(2), [self.spellOutFormatter stringFromNumber:@(2)],
            @(3), [self.spellOutFormatter stringFromNumber:@(3)],
            @(4), [self.spellOutFormatter stringFromNumber:@(4)],
            @(5), [self.spellOutFormatter stringFromNumber:@(5)],
            @(6), [self.spellOutFormatter stringFromNumber:@(6)], nil];
}

@end
