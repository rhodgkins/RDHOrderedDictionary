//
//  RDHOrderedDictionaryCombinationTests.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 24/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RDHOrderedDictionaryCombinationTests : XCTestCase

@property (nonatomic, copy) NSNumberFormatter *spellOutFormatter;

@end

#import "RDHOrderedDictionary.h"

@implementation RDHOrderedDictionaryCombinationTests

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

-(void)testIntersectIgnoringValuesFromDictionary
{
    RDHOrderedDictionary *completeDictionary = [self filledNumberKeyDictionary];
    
    NSDictionary *subDictionary = @{@(1) : [NSNull null], @(0) : [NSNull null], @(10) : [NSNull null]};
    RDHMutableOrderedDictionary *dict = [completeDictionary mutableCopy];
    [dict intersectIgnoringValuesFromDictionary:subDictionary];
    RDHMutableOrderedDictionary *testDict = [RDHMutableOrderedDictionary dictionaryWithObjectsAndKeys:
                                             [self.spellOutFormatter stringFromNumber:@(0)], @(0),
                                             [self.spellOutFormatter stringFromNumber:@(1)], @(1), nil];
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = @{};
    dict = [completeDictionary mutableCopy];
    [dict intersectIgnoringValuesFromDictionary:subDictionary];
    testDict = [RDHMutableOrderedDictionary new];
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = @{@(10) : [NSNull null]};
    dict = [completeDictionary mutableCopy];
    [dict intersectIgnoringValuesFromDictionary:subDictionary];
    testDict = [RDHMutableOrderedDictionary new];
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = [completeDictionary copy];
    dict = [completeDictionary mutableCopy];
    [dict intersectIgnoringValuesFromDictionary:subDictionary];
    testDict = [completeDictionary copy];
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
}

-(void)testIntersectReplacingValuesFromDictionary
{
    RDHOrderedDictionary *completeDictionary = [self filledNumberKeyDictionary];
    
    NSDictionary *subDictionary = @{@(1) : [NSNull null], @(0) : [NSNull null], @(10) : [NSNull null]};
    RDHMutableOrderedDictionary *dict = [completeDictionary mutableCopy];
    [dict intersectReplacingValuesFromDictionary:subDictionary];
    RDHMutableOrderedDictionary *testDict = [RDHMutableOrderedDictionary dictionaryWithObjectsAndKeys:
                                             [NSNull null], @(0),
                                             [NSNull null], @(1), nil];
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = @{};
    dict = [completeDictionary mutableCopy];
    [dict intersectReplacingValuesFromDictionary:subDictionary];
    testDict = [RDHMutableOrderedDictionary new];
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = @{@(10) : [NSNull null]};
    dict = [completeDictionary mutableCopy];
    [dict intersectReplacingValuesFromDictionary:subDictionary];
    testDict = [RDHMutableOrderedDictionary new];
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = [completeDictionary copy];
    dict = [completeDictionary mutableCopy];
    [dict intersectReplacingValuesFromDictionary:subDictionary];
    testDict = [completeDictionary copy];
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = @{@(1) : [self.spellOutFormatter stringFromNumber:@(1)], @(0) : [NSNull null], @(10) : [NSNull null]};
    dict = [completeDictionary mutableCopy];
    [dict intersectReplacingValuesFromDictionary:subDictionary];
    testDict = [RDHMutableOrderedDictionary dictionaryWithObjectsAndKeys:
                [NSNull null], @(0),
                [self.spellOutFormatter stringFromNumber:@(1)], @(1), nil];
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    RDHMutableOrderedDictionary *completeMutableDictionary = [[self filledNumberKeyDictionary] mutableCopy];
    [completeMutableDictionary setObject:@"EXTRA OBJECT" forKey:@"KEY"];
    [completeMutableDictionary setObject:[self.spellOutFormatter stringFromNumber:@(0)] forKey:@(0)];
    
    RDHOrderedDictionary *subOrderedDictionary = [RDHMutableOrderedDictionary dictionaryWithObjectsAndKeys:
                                                  @"NEW OBJECT", @"KEY",
                                                  [NSNull null], @(10),
                                                  @"STRING FOR 1", @(1),
                                                  [NSNull null], @(0), nil];
    dict = [completeMutableDictionary mutableCopy];
    [dict intersectReplacingValuesFromDictionary:subOrderedDictionary];
    testDict = [RDHMutableOrderedDictionary dictionaryWithObjectsAndKeys:
                                                    @"STRING FOR 1", @(1),
                                                    @"NEW OBJECT", @"KEY",
                                                    [NSNull null], @(0), nil];
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
}

-(void)testMinus
{
    RDHOrderedDictionary *completeDictionary = [self filledNumberKeyDictionary];
    
    NSDictionary *subDictionary = @{@(1) : [NSNull null], @(0) : [NSNull null], @(10) : [NSNull null]};
    RDHMutableOrderedDictionary *dict = [completeDictionary mutableCopy];
    [dict minusDictionary:subDictionary];
    RDHMutableOrderedDictionary *testDict = [completeDictionary mutableCopy];
    [testDict removeObjectsForKeys:[subDictionary allKeys]];
    XCTAssertEqualObjects(dict, testDict, @"Minus dictionary not equal");
    
    
    subDictionary = @{};
    dict = [completeDictionary mutableCopy];
    [dict minusDictionary:subDictionary];
    testDict = [completeDictionary mutableCopy];
    XCTAssertEqualObjects(dict, testDict, @"Minus dictionary not equal");
    
    
    subDictionary = @{@(10) : [NSNull null]};
    dict = [completeDictionary mutableCopy];
    [dict minusDictionary:subDictionary];
    testDict = [completeDictionary mutableCopy];
    [testDict removeObjectsForKeys:[subDictionary allKeys]];
    XCTAssertEqualObjects(dict, testDict, @"Minus dictionary not equal");
    
    
    subDictionary = [completeDictionary copy];
    dict = [completeDictionary mutableCopy];
    [dict minusDictionary:subDictionary];
    testDict = [RDHMutableOrderedDictionary new];
    XCTAssertEqualObjects(dict, testDict, @"Minus dictionary not equal");
    
    
    subDictionary = @{@(1) : [self.spellOutFormatter stringFromNumber:@(1)], @(0) : [NSNull null], @(10) : [NSNull null]};
    dict = [completeDictionary mutableCopy];
    [dict minusDictionary:subDictionary];
    testDict = [completeDictionary mutableCopy];
    [testDict removeObjectsForKeys:[subDictionary allKeys]];
    XCTAssertEqualObjects(dict, testDict, @"Minus dictionary not equal");
}

-(void)testUnion
{
    RDHOrderedDictionary *completeDictionary = [self filledNumberKeyDictionary];
    
    NSDictionary *subDictionary = @{@(1) : [NSNull null], @(0) : [NSNull null], @(10) : [NSNull null]};
    RDHMutableOrderedDictionary *dict = [completeDictionary mutableCopy];
    [dict unionDictionary:subDictionary];
    RDHMutableOrderedDictionary *testDict = [completeDictionary mutableCopy];
    [testDict addEntriesFromDictionary:subDictionary];
    XCTAssertEqualObjects(dict, testDict, @"Union dictionary not equal");
    
    
    subDictionary = @{};
    dict = [completeDictionary mutableCopy];
    [dict unionDictionary:subDictionary];
    testDict = [completeDictionary mutableCopy];
    XCTAssertEqualObjects(dict, testDict, @"Union dictionary not equal");
    
    
    subDictionary = @{@(10) : [NSNull null]};
    dict = [completeDictionary mutableCopy];
    [dict unionDictionary:subDictionary];
    testDict = [completeDictionary mutableCopy];
    [testDict addEntriesFromDictionary:subDictionary];
    XCTAssertEqualObjects(dict, testDict, @"Union dictionary not equal");
    
    
    subDictionary = [completeDictionary copy];
    dict = [completeDictionary mutableCopy];
    [dict unionDictionary:subDictionary];
    testDict = [completeDictionary mutableCopy];
    XCTAssertEqualObjects(dict, testDict, @"Union dictionary not equal");
    
    
    subDictionary = @{@(1) : [self.spellOutFormatter stringFromNumber:@(1)], @(0) : [NSNull null], @(10) : [NSNull null]};
    dict = [completeDictionary mutableCopy];
    [dict unionDictionary:subDictionary];
    testDict = [completeDictionary mutableCopy];
    [testDict addEntriesFromDictionary:subDictionary];
    XCTAssertEqualObjects(dict, testDict, @"Union dictionary not equal");
}

#pragma mark - Dictionary creation

-(RDHOrderedDictionary *)filledNumberKeyDictionary
{
    return [RDHOrderedDictionary dictionaryWithObjectsAndKeys:
            [self.spellOutFormatter stringFromNumber:@(2)], @(2),
            [self.spellOutFormatter stringFromNumber:@(5)], @(5),
            [self.spellOutFormatter stringFromNumber:@(3)], @(3),
            [self.spellOutFormatter stringFromNumber:@(4)], @(4),
            [self.spellOutFormatter stringFromNumber:@(0)], @(0),
            [self.spellOutFormatter stringFromNumber:@(6)], @(6),
            [self.spellOutFormatter stringFromNumber:@(1)], @(1), nil];
}

@end
