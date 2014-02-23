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

#define FIRST (@(2))
#define SECOND (@(6))
#define SECOND_TO_LAST (@(1))
#define LAST (@(5))

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
    
    XCTAssertEqualObjects([numberKeysDict firstKey], FIRST, @"The first key is not correct");
    XCTAssertEqualObjects([stringKeysDict firstKey], [self.spellOutFormatter stringFromNumber:FIRST], @"The first key is not correct");
}

-(void)testFirstValue
{
    RDHOrderedDictionary *numberKeysDict = [self filledNumberKeyDictionary];
    RDHOrderedDictionary *stringKeysDict = [self filledStringKeyDictionary];
    
    XCTAssertEqualObjects([numberKeysDict firstValue], [self.spellOutFormatter stringFromNumber:FIRST], @"The first value is not correct");
    XCTAssertEqualObjects([stringKeysDict firstValue], FIRST, @"The first value is not correct");
}

-(void)testLastKey
{
    RDHOrderedDictionary *numberKeysDict = [self filledNumberKeyDictionary];
    RDHOrderedDictionary *stringKeysDict = [self filledStringKeyDictionary];

    XCTAssertEqualObjects([numberKeysDict lastKey], LAST, @"The last key is not correct");
    XCTAssertEqualObjects([stringKeysDict lastKey], [self.spellOutFormatter stringFromNumber:LAST], @"The last key is not correct");
}

-(void)testLastValue
{
    RDHOrderedDictionary *numberKeysDict = [self filledNumberKeyDictionary];
    RDHOrderedDictionary *stringKeysDict = [self filledStringKeyDictionary];
    
    XCTAssertEqualObjects([numberKeysDict lastValue], [self.spellOutFormatter stringFromNumber:LAST], @"The last value is not correct");
    XCTAssertEqualObjects([stringKeysDict lastValue], LAST, @"The last value is not correct");
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

-(void)testRemoveFirstEntry
{
    RDHMutableOrderedDictionary *numberKeysDict = [self filledNumberKeyMutableDictionary];
    RDHMutableOrderedDictionary *stringKeysDict = [self filledStringKeyMutableDictionary];
    
    NSNumber *secondKey = SECOND;
    NSString *secondValue = [self.spellOutFormatter stringFromNumber:secondKey];
    
    [numberKeysDict removeFirstEntry];
    
    XCTAssertEqualObjects([numberKeysDict firstKey], secondKey, @"First key does not match after removing the previous first entry");
    XCTAssertEqualObjects([numberKeysDict firstValue], secondValue, @"First value does not match after removing the previous first entry");
    
    
    [stringKeysDict removeFirstEntry];
    
    XCTAssertEqualObjects([stringKeysDict firstKey], secondValue, @"First key does not match after removing the previous first entry");
    XCTAssertEqualObjects([stringKeysDict firstValue], secondKey, @"First value does not match after removing the previous first entry");
}

-(void)testRemoveLastEntry
{
    RDHMutableOrderedDictionary *numberKeysDict = [self filledNumberKeyMutableDictionary];
    RDHMutableOrderedDictionary *stringKeysDict = [self filledStringKeyMutableDictionary];
    
    NSNumber *secondToLastKey = SECOND_TO_LAST;
    NSString *secondToLastValue = [self.spellOutFormatter stringFromNumber:secondToLastKey];
    
    [numberKeysDict removeLastEntry];
    
    XCTAssertEqualObjects([numberKeysDict lastKey], secondToLastKey, @"Last key does not match after removing the previous last entry");
    XCTAssertEqualObjects([numberKeysDict lastValue], secondToLastValue, @"Last value does not match after removing the previous last entry");
    
    
    [stringKeysDict removeLastEntry];
    
    XCTAssertEqualObjects([stringKeysDict lastKey], secondToLastValue, @"Last key does not match after removing the previous last entry");
    XCTAssertEqualObjects([stringKeysDict lastValue], secondToLastKey, @"Last value does not match after removing the previous last entry");
}

#pragma mark - Dictionary creation

-(RDHOrderedDictionary *)filledNumberKeyDictionary
{
    return [RDHOrderedDictionary dictionaryWithObjectsAndKeys:
            [self.spellOutFormatter stringFromNumber:FIRST], FIRST,
            [self.spellOutFormatter stringFromNumber:SECOND], SECOND,
            [self.spellOutFormatter stringFromNumber:@(3)], @(3),
            [self.spellOutFormatter stringFromNumber:@(4)], @(4),
            [self.spellOutFormatter stringFromNumber:@(0)], @(0),
            [self.spellOutFormatter stringFromNumber:SECOND_TO_LAST], SECOND_TO_LAST,
            [self.spellOutFormatter stringFromNumber:LAST], LAST, nil];
}

-(RDHOrderedDictionary *)filledStringKeyDictionary
{
    return [RDHOrderedDictionary dictionaryWithObjectsAndKeys:
            FIRST, [self.spellOutFormatter stringFromNumber:FIRST],
            SECOND, [self.spellOutFormatter stringFromNumber:SECOND],
            @(3), [self.spellOutFormatter stringFromNumber:@(3)],
            @(4), [self.spellOutFormatter stringFromNumber:@(4)],
            @(0), [self.spellOutFormatter stringFromNumber:@(0)],
            SECOND_TO_LAST, [self.spellOutFormatter stringFromNumber:SECOND_TO_LAST],
            LAST, [self.spellOutFormatter stringFromNumber:LAST], nil];
}

-(RDHMutableOrderedDictionary *)filledNumberKeyMutableDictionary
{
    return [RDHMutableOrderedDictionary dictionaryWithObjectsAndKeys:
            [self.spellOutFormatter stringFromNumber:FIRST], FIRST,
            [self.spellOutFormatter stringFromNumber:SECOND], SECOND,
            [self.spellOutFormatter stringFromNumber:@(3)], @(3),
            [self.spellOutFormatter stringFromNumber:@(4)], @(4),
            [self.spellOutFormatter stringFromNumber:@(0)], @(0),
            [self.spellOutFormatter stringFromNumber:SECOND_TO_LAST], SECOND_TO_LAST,
            [self.spellOutFormatter stringFromNumber:LAST], LAST, nil];
}

-(RDHMutableOrderedDictionary *)filledStringKeyMutableDictionary
{
    return [RDHMutableOrderedDictionary dictionaryWithObjectsAndKeys:
            FIRST, [self.spellOutFormatter stringFromNumber:FIRST],
            SECOND, [self.spellOutFormatter stringFromNumber:SECOND],
            @(3), [self.spellOutFormatter stringFromNumber:@(3)],
            @(4), [self.spellOutFormatter stringFromNumber:@(4)],
            @(0), [self.spellOutFormatter stringFromNumber:@(0)],
            SECOND_TO_LAST, [self.spellOutFormatter stringFromNumber:SECOND_TO_LAST],
            LAST, [self.spellOutFormatter stringFromNumber:LAST], nil];
}

@end
