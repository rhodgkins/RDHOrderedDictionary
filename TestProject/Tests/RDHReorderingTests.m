//
//  RDHReorderingTests.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RDHReorderingTests : XCTestCase

@property (nonatomic, copy) NSNumberFormatter *spellOutFormatter;

@end

#import "RDHOrderedDictionary.h"

static NSUInteger const RDHObjectCount = 10000;

@implementation RDHReorderingTests

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

-(void)testImmutableReorderingFromInitializers
{
    NSDictionary *numberKeysDict = [RDHOrderedDictionary dictionaryWithObjectsAndKeys:
                                                   [self.spellOutFormatter stringFromNumber:@(0)], @(0),
                                                   [self.spellOutFormatter stringFromNumber:@(1)], @(1),
                                                   [self.spellOutFormatter stringFromNumber:@(2)], @(2),
                                                   [self.spellOutFormatter stringFromNumber:@(3)], @(3),
                                                   [self.spellOutFormatter stringFromNumber:@(4)], @(4),
                                                   [self.spellOutFormatter stringFromNumber:@(5)], @(5),
                                                   [self.spellOutFormatter stringFromNumber:@(6)], @(6),
                                                   [self.spellOutFormatter stringFromNumber:@(0)], @(0), nil];
    
    NSArray *ordering = @[@(1), @(2), @(3), @(4), @(5), @(6), @(0)];
    
    
    
    NSDictionary *stringKeysDict = [RDHOrderedDictionary dictionaryWithObjectsAndKeys:
                                                   @(0), [self.spellOutFormatter stringFromNumber:@(0)],
                                                   @(1), [self.spellOutFormatter stringFromNumber:@(1)],
                                                   @(2), [self.spellOutFormatter stringFromNumber:@(2)],
                                                   @(3), [self.spellOutFormatter stringFromNumber:@(3)],
                                                   @(4), [self.spellOutFormatter stringFromNumber:@(4)],
                                                   @(5), [self.spellOutFormatter stringFromNumber:@(5)],
                                                   @(6), [self.spellOutFormatter stringFromNumber:@(6)],
                                                   @(0), [self.spellOutFormatter stringFromNumber:@(0)], nil];
    
    [self checkDictionaryWithNumberKeys:numberKeysDict order:ordering];
    
    [self checkDictionaryWithStringKeys:stringKeysDict order:ordering];
}

-(void)testMutableReorderingFromInitializers
{
    NSDictionary *numberKeysDict = [RDHMutableOrderedDictionary dictionaryWithObjectsAndKeys:
                                                   [self.spellOutFormatter stringFromNumber:@(0)], @(0),
                                                   [self.spellOutFormatter stringFromNumber:@(1)], @(1),
                                                   [self.spellOutFormatter stringFromNumber:@(2)], @(2),
                                                   [self.spellOutFormatter stringFromNumber:@(3)], @(3),
                                                   [self.spellOutFormatter stringFromNumber:@(4)], @(4),
                                                   [self.spellOutFormatter stringFromNumber:@(5)], @(5),
                                                   [self.spellOutFormatter stringFromNumber:@(6)], @(6),
                                                   [self.spellOutFormatter stringFromNumber:@(0)], @(0), nil];
    
    NSArray *ordering = @[@(1), @(2), @(3), @(4), @(5), @(6), @(0)];
    
    
    
    NSDictionary *stringKeysDict = [RDHMutableOrderedDictionary dictionaryWithObjectsAndKeys:
                                                   @(0), [self.spellOutFormatter stringFromNumber:@(0)],
                                                   @(1), [self.spellOutFormatter stringFromNumber:@(1)],
                                                   @(2), [self.spellOutFormatter stringFromNumber:@(2)],
                                                   @(3), [self.spellOutFormatter stringFromNumber:@(3)],
                                                   @(4), [self.spellOutFormatter stringFromNumber:@(4)],
                                                   @(5), [self.spellOutFormatter stringFromNumber:@(5)],
                                                   @(6), [self.spellOutFormatter stringFromNumber:@(6)],
                                                   @(0), [self.spellOutFormatter stringFromNumber:@(0)], nil];
    
    [self checkDictionaryWithNumberKeys:numberKeysDict order:ordering];
    
    [self checkDictionaryWithStringKeys:stringKeysDict order:ordering];
}

#pragma mark - Dictionary checking methods

-(void)checkDictionaryWithNumberKeys:(NSDictionary *)dictionary order:(NSArray *)ordering
{
    XCTAssertEqual([dictionary count], [ordering count], @"Incorrect number of items in the dictionary");
    
    __block NSUInteger i = 0;
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSString *obj, BOOL *stop) {
        NSNumber *iNumber = ordering[i++];
        NSString *iString = [self.spellOutFormatter stringFromNumber:iNumber];
        
        XCTAssertEqualObjects(iNumber, key, @"The key ordering is not correct");
        XCTAssertEqualObjects(iString, obj, @"The value ordering is not correct");
    }];
}

-(void)checkDictionaryWithStringKeys:(NSDictionary *)dictionary order:(NSArray *)ordering
{
    XCTAssertEqual([dictionary count], [ordering count], @"Incorrect number of items in the dictionary");
    
    __block NSUInteger i = 0;
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
        NSNumber *iNumber = ordering[i++];
        NSString *iString = [self.spellOutFormatter stringFromNumber:iNumber];
        
        XCTAssertEqualObjects(iString, key, @"The key ordering is not correct");
        XCTAssertEqualObjects(iNumber, obj, @"The value ordering is not correct");
    }];
}

@end
