//
//  RDHInitalizerTests.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RDHInitalizerTests : XCTestCase

@property (nonatomic, copy) NSNumberFormatter *spellOutFormatter;

@end

#import "RDHOrderedDictionary.h"

static NSUInteger const RDHObjectCount = 10000;

@implementation RDHInitalizerTests

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

/// Nothing is really tested, just to see the ordering of standard dictionaries
-(void)testNSDictionaries
{
    __unused NSDictionary *numberKeysDict = @{@(0) : [self.spellOutFormatter stringFromNumber:@(0)],
                                     @(1) : [self.spellOutFormatter stringFromNumber:@(1)],
                                     @(2) : [self.spellOutFormatter stringFromNumber:@(2)],
                                     @(3) : [self.spellOutFormatter stringFromNumber:@(3)],
                                     @(4) : [self.spellOutFormatter stringFromNumber:@(4)],
                                     @(5) : [self.spellOutFormatter stringFromNumber:@(5)],
                                     @(6) : [self.spellOutFormatter stringFromNumber:@(6)]};
    __unused NSDictionary *stringKeysDict = @{[self.spellOutFormatter stringFromNumber:@(0)] : @(0),
                                     [self.spellOutFormatter stringFromNumber:@(1)] : @(1),
                                     [self.spellOutFormatter stringFromNumber:@(2)] : @(2),
                                     [self.spellOutFormatter stringFromNumber:@(3)] : @(3),
                                     [self.spellOutFormatter stringFromNumber:@(4)] : @(4),
                                     [self.spellOutFormatter stringFromNumber:@(5)] : @(5),
                                     [self.spellOutFormatter stringFromNumber:@(6)] : @(6)};
}

/// Nothing is really tested, just to see the ordering of standard dictionaries
-(void)testNSMutableDictionaries
{
    NSMutableDictionary *numberKeysDict = [NSMutableDictionary dictionaryWithCapacity:RDHObjectCount];
    NSMutableDictionary *stringKeysDict = [NSMutableDictionary dictionaryWithCapacity:RDHObjectCount];
    
    for (NSUInteger i=0; i<RDHObjectCount; i++) {
        NSNumber *iNumber = @(i);
        NSString *iString = [self.spellOutFormatter stringFromNumber:iNumber];
        
        numberKeysDict[iNumber] = iString;
        stringKeysDict[iString] = iNumber;
    }
}

/// Tests the ordering of the immutable dictionaries
-(void)testImmutableOrdering
{
    NSDictionary *numberKeysDict = [RDHOrderedDictionary dictionaryWithObjectsAndKeys:
                                    [self.spellOutFormatter stringFromNumber:@(0)], @(0),
                                    [self.spellOutFormatter stringFromNumber:@(1)], @(1),
                                    [self.spellOutFormatter stringFromNumber:@(2)], @(2),
                                    [self.spellOutFormatter stringFromNumber:@(3)], @(3),
                                    [self.spellOutFormatter stringFromNumber:@(4)], @(4),
                                    [self.spellOutFormatter stringFromNumber:@(5)], @(5),
                                    [self.spellOutFormatter stringFromNumber:@(6)], @(6), nil];
    
    [self checkDictionaryWithNumberKeys:numberKeysDict count:7];
    
    
    NSDictionary *stringKeysDict = [RDHOrderedDictionary dictionaryWithObjectsAndKeys:
                                    @(0), [self.spellOutFormatter stringFromNumber:@(0)],
                                    @(1), [self.spellOutFormatter stringFromNumber:@(1)],
                                    @(2), [self.spellOutFormatter stringFromNumber:@(2)],
                                    @(3), [self.spellOutFormatter stringFromNumber:@(3)],
                                    @(4), [self.spellOutFormatter stringFromNumber:@(4)],
                                    @(5), [self.spellOutFormatter stringFromNumber:@(5)],
                                    @(6), [self.spellOutFormatter stringFromNumber:@(6)], nil];
    
    [self checkDictionaryWithStringKeys:stringKeysDict count:7];
}

/// Tests the ordering of the mutable dictionaries
-(void)testMutableOrderingByInitializing
{
    NSDictionary *numberKeysDict = [RDHMutableOrderedDictionary dictionaryWithObjectsAndKeys:
                                    [self.spellOutFormatter stringFromNumber:@(0)], @(0),
                                    [self.spellOutFormatter stringFromNumber:@(1)], @(1),
                                    [self.spellOutFormatter stringFromNumber:@(2)], @(2),
                                    [self.spellOutFormatter stringFromNumber:@(3)], @(3),
                                    [self.spellOutFormatter stringFromNumber:@(4)], @(4),
                                    [self.spellOutFormatter stringFromNumber:@(5)], @(5),
                                    [self.spellOutFormatter stringFromNumber:@(6)], @(6), nil];
    
    [self checkDictionaryWithNumberKeys:numberKeysDict count:7];
    
    
    NSDictionary *stringKeysDict = [RDHMutableOrderedDictionary dictionaryWithObjectsAndKeys:
                                    @(0), [self.spellOutFormatter stringFromNumber:@(0)],
                                    @(1), [self.spellOutFormatter stringFromNumber:@(1)],
                                    @(2), [self.spellOutFormatter stringFromNumber:@(2)],
                                    @(3), [self.spellOutFormatter stringFromNumber:@(3)],
                                    @(4), [self.spellOutFormatter stringFromNumber:@(4)],
                                    @(5), [self.spellOutFormatter stringFromNumber:@(5)],
                                    @(6), [self.spellOutFormatter stringFromNumber:@(6)], nil];
    
    [self checkDictionaryWithStringKeys:stringKeysDict count:7];
}

/// Tests the ordering of the mutable dictionaries when initialized with +dictionary by adding [0,RDHObjectCount) and checking the ordering of the keys are correct
-(void)testMutableOrderingByAddingIntializedWithDictionary
{
    RDHMutableOrderedDictionary *numberKeysDict = [RDHMutableOrderedDictionary dictionary];
    RDHMutableOrderedDictionary *stringKeysDict = [RDHMutableOrderedDictionary dictionary];
    
    for (NSUInteger i=0; i<RDHObjectCount; i++) {
        NSNumber *iNumber = @(i);
        NSString *iString = [self.spellOutFormatter stringFromNumber:iNumber];
        
        numberKeysDict[iNumber] = iString;
        stringKeysDict[iString] = iNumber;
    }
    
    [self checkDictionaryWithNumberKeys:numberKeysDict count:RDHObjectCount];
    [self checkDictionaryWithStringKeys:stringKeysDict count:RDHObjectCount];
}

/// Tests the ordering of the mutable dictionaries when initialized with +new by adding [0,RDHObjectCount) and checking the ordering of the keys are correct
-(void)testMutableOrderingByAddingIntializedWithNew
{
    RDHMutableOrderedDictionary *numberKeysDict = [RDHMutableOrderedDictionary new];
    RDHMutableOrderedDictionary *stringKeysDict = [RDHMutableOrderedDictionary new];
    
    for (NSUInteger i=0; i<RDHObjectCount; i++) {
        NSNumber *iNumber = @(i);
        NSString *iString = [self.spellOutFormatter stringFromNumber:iNumber];
        
        numberKeysDict[iNumber] = iString;
        stringKeysDict[iString] = iNumber;
    }
    
    [self checkDictionaryWithNumberKeys:numberKeysDict count:RDHObjectCount];
    [self checkDictionaryWithStringKeys:stringKeysDict count:RDHObjectCount];
}

/// Tests the ordering of the mutable dictionaries when initialized with +dictionaryWithCapacity by adding [0,RDHObjectCount) and checking the ordering of the keys are correct
-(void)testMutableOrderingByAddingIntializedWithInitWithCapacity
{
    RDHMutableOrderedDictionary *numberKeysDict = [RDHMutableOrderedDictionary dictionaryWithCapacity:RDHObjectCount];
    RDHMutableOrderedDictionary *stringKeysDict = [RDHMutableOrderedDictionary dictionaryWithCapacity:RDHObjectCount];
    
    for (NSUInteger i=0; i<RDHObjectCount; i++) {
        NSNumber *iNumber = @(i);
        NSString *iString = [self.spellOutFormatter stringFromNumber:iNumber];
        
        numberKeysDict[iNumber] = iString;
        stringKeysDict[iString] = iNumber;
    }
    
    [self checkDictionaryWithNumberKeys:numberKeysDict count:RDHObjectCount];
    [self checkDictionaryWithStringKeys:stringKeysDict count:RDHObjectCount];
}

#pragma mark - Dictionary checking methods

-(void)checkDictionaryWithNumberKeys:(NSDictionary *)dictionary count:(NSUInteger)count
{
    XCTAssertEqual([dictionary count], count, @"Incorrect number of items in the dictionary");
    
    __block NSUInteger i = 0;
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSString *obj, BOOL *stop) {
        NSNumber *iNumber = @(i++);
        NSString *iString = [self.spellOutFormatter stringFromNumber:iNumber];
        
        XCTAssertEqualObjects(iNumber, key, @"The key ordering is not correct");
        XCTAssertEqualObjects(iString, obj, @"The value ordering is not correct");
    }];
}

-(void)checkDictionaryWithStringKeys:(NSDictionary *)dictionary count:(NSUInteger)count
{
    XCTAssertEqual([dictionary count], count, @"Incorrect number of items in the dictionary");
    
    __block NSUInteger i = 0;
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
        NSNumber *iNumber = @(i++);
        NSString *iString = [self.spellOutFormatter stringFromNumber:iNumber];
        
        XCTAssertEqualObjects(iString, key, @"The key ordering is not correct");
        XCTAssertEqualObjects(iNumber, obj, @"The value ordering is not correct");
    }];
}

@end
