//
//  RDHDictionaryCombinationTests.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 24/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RDHDictionaryCombinationTests : XCTestCase

@property (nonatomic, copy) NSNumberFormatter *spellOutFormatter;

@end

#import "NSMutableDictionary+RDHCombinationOperations.h"

@implementation RDHDictionaryCombinationTests

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
    NSDictionary *completeDictionary = [self filledNumberKeyDictionary];
    
    NSDictionary *subDictionary = @{@(1) : [NSNull null], @(0) : [NSNull null], @(10) : [NSNull null]};
    NSMutableDictionary *dict = [completeDictionary mutableCopy];
    [dict intersectIgnoringValuesFromDictionary:subDictionary];
    NSDictionary *testDict = @{@(1) : [self.spellOutFormatter stringFromNumber:@(1)],
                               @(0) : [self.spellOutFormatter stringFromNumber:@(0)]};
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = @{};
    dict = [completeDictionary mutableCopy];
    [dict intersectIgnoringValuesFromDictionary:subDictionary];
    testDict = @{};
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = @{@(10) : [NSNull null]};
    dict = [completeDictionary mutableCopy];
    [dict intersectIgnoringValuesFromDictionary:subDictionary];
    testDict = @{};
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = [completeDictionary copy];
    dict = [completeDictionary mutableCopy];
    [dict intersectIgnoringValuesFromDictionary:subDictionary];
    testDict = [completeDictionary copy];
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
}

-(void)testIntersectReplacingValuesFromDictionary
{
    NSDictionary *completeDictionary = [self filledNumberKeyDictionary];
    
    NSDictionary *subDictionary = @{@(1) : [NSNull null], @(0) : [NSNull null], @(10) : [NSNull null]};
    NSMutableDictionary *dict = [completeDictionary mutableCopy];
    [dict intersectReplacingValuesFromDictionary:subDictionary];
    NSDictionary *testDict = @{@(1) : [NSNull null],
                               @(0) : [NSNull null]};
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = @{};
    dict = [completeDictionary mutableCopy];
    [dict intersectReplacingValuesFromDictionary:subDictionary];
    testDict = @{};
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = @{@(10) : [NSNull null]};
    dict = [completeDictionary mutableCopy];
    [dict intersectReplacingValuesFromDictionary:subDictionary];
    testDict = @{};
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    
    subDictionary = [completeDictionary copy];
    dict = [completeDictionary mutableCopy];
    [dict intersectReplacingValuesFromDictionary:subDictionary];
    testDict = [completeDictionary copy];
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
    
    subDictionary = @{@(1) : [self.spellOutFormatter stringFromNumber:@(1)], @(0) : [NSNull null], @(10) : [NSNull null]};
    dict = [completeDictionary mutableCopy];
    [dict intersectReplacingValuesFromDictionary:subDictionary];
    testDict = @{@(1) : [self.spellOutFormatter stringFromNumber:@(1)],
                @(0) : [NSNull null]};
    XCTAssertEqualObjects(dict, testDict, @"Intersection dictionary not equal");
}

-(void)testMinus
{
    NSDictionary *completeDictionary = [self filledNumberKeyDictionary];
    
    NSDictionary *subDictionary = @{@(1) : [NSNull null], @(0) : [NSNull null], @(10) : [NSNull null]};
    NSMutableDictionary *dict = [completeDictionary mutableCopy];
    [dict minusDictionary:subDictionary];
    NSMutableDictionary *testDict = [completeDictionary mutableCopy];
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
    testDict = [@{} mutableCopy];;
    XCTAssertEqualObjects(dict, testDict, @"Minus dictionary not equal");
    
    
    subDictionary = @{@(1) : [self.spellOutFormatter stringFromNumber:@(1)], @(0) : [NSNull null], @(10) : [NSNull null]};
    dict = [completeDictionary mutableCopy];
    [dict minusDictionary:subDictionary];
    testDict = [completeDictionary mutableCopy];
    [testDict removeObjectsForKeys:[subDictionary allKeys]];
    XCTAssertEqualObjects(dict, testDict, @"Minus dictionary not equal");
}

#pragma mark - Dictionary creation

-(NSDictionary *)filledNumberKeyDictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [self.spellOutFormatter stringFromNumber:@(2)], @(2),
            [self.spellOutFormatter stringFromNumber:@(5)], @(5),
            [self.spellOutFormatter stringFromNumber:@(3)], @(3),
            [self.spellOutFormatter stringFromNumber:@(4)], @(4),
            [self.spellOutFormatter stringFromNumber:@(0)], @(0),
            [self.spellOutFormatter stringFromNumber:@(6)], @(6),
            [self.spellOutFormatter stringFromNumber:@(1)], @(1), nil];
}

@end
