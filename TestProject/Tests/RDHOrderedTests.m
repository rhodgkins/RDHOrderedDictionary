//
//  RDHOrderedTests.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RDHOrderedTests : XCTestCase

@property (nonatomic, copy) NSNumberFormatter *spellOutFormatter;

@end

#import "RDHOrderedDictionary.h"

@implementation RDHOrderedTests

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

-(void)testFirstKey
{
    RDHOrderedDictionary *numberKeysDict = [self filledNumberKeyDictionary];
    RDHOrderedDictionary *stringKeysDict = [self filledStringKeyDictionary];
    
    XCTAssertEqualObjects([numberKeysDict firstKey], @(0), @"The first key is not correct");
    XCTAssertEqualObjects([stringKeysDict firstKey], [self.spellOutFormatter stringFromNumber:@(0)], @"The first key is not correct");
}

-(void)testFirstValue
{
    RDHOrderedDictionary *numberKeysDict = [self filledNumberKeyDictionary];
    RDHOrderedDictionary *stringKeysDict = [self filledStringKeyDictionary];
    
    XCTAssertEqualObjects([numberKeysDict firstValue], [self.spellOutFormatter stringFromNumber:@(0)], @"The first value is not correct");
    XCTAssertEqualObjects([stringKeysDict firstValue], @(0), @"The first value is not correct");
}

-(void)testLastKey
{
    RDHOrderedDictionary *numberKeysDict = [self filledNumberKeyDictionary];
    RDHOrderedDictionary *stringKeysDict = [self filledStringKeyDictionary];
    
    XCTAssertEqualObjects([numberKeysDict lastKey], @(6), @"The last key is not correct");
    XCTAssertEqualObjects([stringKeysDict lastKey], [self.spellOutFormatter stringFromNumber:@(6)], @"The last key is not correct");
}

-(void)testLastValue
{
    RDHOrderedDictionary *numberKeysDict = [self filledNumberKeyDictionary];
    RDHOrderedDictionary *stringKeysDict = [self filledStringKeyDictionary];
    
    XCTAssertEqualObjects([numberKeysDict lastValue], [self.spellOutFormatter stringFromNumber:@(6)], @"The last value is not correct");
    XCTAssertEqualObjects([stringKeysDict lastValue], @(6), @"The last value is not correct");
}

-(void)testReverseKeyEnumerator
{
    RDHOrderedDictionary *numberKeysDict = [self filledNumberKeyDictionary];
    RDHOrderedDictionary *stringKeysDict = [self filledStringKeyDictionary];
    
    NSEnumerator *reverseEnumerator = [numberKeysDict reverseKeyEnumerator];
    [numberKeysDict enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id key, id obj, BOOL *stop) {
        id enumObj = [reverseEnumerator nextObject];
        XCTAssertEqualObjects(key, enumObj, @"Reverse key enumerator order differs");
    }];
    
    reverseEnumerator = [stringKeysDict reverseKeyEnumerator];
    [stringKeysDict enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id key, id obj, BOOL *stop) {
        id enumObj = [reverseEnumerator nextObject];
        XCTAssertEqualObjects(key, enumObj, @"Reverse key enumerator order differs");
    }];
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
