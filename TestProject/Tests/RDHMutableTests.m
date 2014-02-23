//
//  RDHMutableTests.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RDHMutableTests : XCTestCase

@property (nonatomic, copy) NSNumberFormatter *spellOutFormatter;

@end

#import "RDHOrderedDictionary.h"

static NSUInteger const RDHObjectCount = 100000;

@implementation RDHMutableTests

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

-(void)testImmutableToImmutableCopy
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
    
    NSDictionary *numberKeysDictCopy = [numberKeysDict copy];
    NSDictionary *stringKeysDictCopy = [stringKeysDict copy];
    
    XCTAssertEqualObjects(numberKeysDict, numberKeysDictCopy, @"Copying immutable dictionary has not produced the same dictionary");
    XCTAssertEqualObjects(stringKeysDict, stringKeysDictCopy, @"Copying immutable dictionary has not produced the same dictionary");
    
    [self checkDictionaryWithNumberKeys:numberKeysDictCopy order:ordering];
    
    [self checkDictionaryWithStringKeys:stringKeysDictCopy order:ordering];
    
    numberKeysDictCopy = [NSDictionary dictionaryWithDictionary:numberKeysDict];
    stringKeysDictCopy = [NSDictionary dictionaryWithDictionary:stringKeysDict];
    
    // These should be equal as its asking a dictionary if an ordered dictionary is equal to it
    XCTAssertEqualObjects(numberKeysDictCopy, numberKeysDict, @"These should be equal as its asking a dictionary if an ordered dictionary is equal to it");
    XCTAssertEqualObjects(stringKeysDictCopy, stringKeysDict, @"These should be equal as its asking a dictionary if an ordered dictionary is equal to it");
    
    // These should be NOT equal as its asking a ordered dictionary if an dictionary is equal to it
    XCTAssertNotEqualObjects(numberKeysDict, numberKeysDictCopy, @"These should be NOT equal as its asking a ordered dictionary if an dictionary is equal to it");
    XCTAssertNotEqualObjects(stringKeysDict, stringKeysDictCopy, @"These should be NOT equal as its asking a ordered dictionary if an dictionary is equal to it");
}

-(void)testImmutableToMutableCopy
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
    
    NSDictionary *numberKeysDictCopy = [numberKeysDict mutableCopy];
    NSDictionary *stringKeysDictCopy = [stringKeysDict mutableCopy];
    
    XCTAssertEqualObjects(numberKeysDict, numberKeysDictCopy, @"Copying immutable dictionary has not produced the same dictionary");
    XCTAssertEqualObjects(stringKeysDict, stringKeysDictCopy, @"Copying immutable dictionary has not produced the same dictionary");
    
    [self checkDictionaryWithNumberKeys:numberKeysDictCopy order:ordering];
    
    [self checkDictionaryWithStringKeys:stringKeysDictCopy order:ordering];
    
    numberKeysDictCopy = [NSMutableDictionary dictionaryWithDictionary:numberKeysDict];
    stringKeysDictCopy = [NSMutableDictionary dictionaryWithDictionary:stringKeysDict];
    
    // These should be equal as its asking a dictionary if an ordered dictionary is equal to it
    XCTAssertEqualObjects(numberKeysDictCopy, numberKeysDict, @"These should be equal as its asking a dictionary if an ordered dictionary is equal to it");
    XCTAssertEqualObjects(stringKeysDictCopy, stringKeysDict, @"These should be equal as its asking a dictionary if an ordered dictionary is equal to it");
    
    // These should be NOT equal as its asking a ordered dictionary if an dictionary is equal to it
    XCTAssertNotEqualObjects(numberKeysDict, numberKeysDictCopy, @"These should be NOT equal as its asking a ordered dictionary if an dictionary is equal to it");
    XCTAssertNotEqualObjects(stringKeysDict, stringKeysDictCopy, @"These should be NOT equal as its asking a ordered dictionary if an dictionary is equal to it");
}

-(void)testMutableToImmutableCopy
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
    
    NSDictionary *numberKeysDictCopy = [numberKeysDict copy];
    NSDictionary *stringKeysDictCopy = [stringKeysDict copy];
    
    XCTAssertEqualObjects(numberKeysDict, numberKeysDictCopy, @"Copying mutable dictionary has not produced the same dictionary");
    XCTAssertEqualObjects(stringKeysDict, stringKeysDictCopy, @"Copying mutable dictionary has not produced the same dictionary");
    
    [self checkDictionaryWithNumberKeys:numberKeysDictCopy order:ordering];
    
    [self checkDictionaryWithStringKeys:stringKeysDictCopy order:ordering];
    
    numberKeysDictCopy = [NSDictionary dictionaryWithDictionary:numberKeysDict];
    stringKeysDictCopy = [NSDictionary dictionaryWithDictionary:stringKeysDict];
    
    // These should be equal as its asking a dictionary if an ordered dictionary is equal to it
    XCTAssertEqualObjects(numberKeysDictCopy, numberKeysDict, @"These should be equal as its asking a dictionary if an ordered dictionary is equal to it");
    XCTAssertEqualObjects(stringKeysDictCopy, stringKeysDict, @"These should be equal as its asking a dictionary if an ordered dictionary is equal to it");
    
    // These should be NOT equal as its asking a ordered dictionary if an dictionary is equal to it
    XCTAssertNotEqualObjects(numberKeysDict, numberKeysDictCopy, @"These should be NOT equal as its asking a ordered dictionary if an dictionary is equal to it");
    XCTAssertNotEqualObjects(stringKeysDict, stringKeysDictCopy, @"These should be NOT equal as its asking a ordered dictionary if an dictionary is equal to it");
}

-(void)testMutableToMutableCopy
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
    
    NSDictionary *numberKeysDictCopy = [numberKeysDict mutableCopy];
    NSDictionary *stringKeysDictCopy = [stringKeysDict mutableCopy];
    
    XCTAssertEqualObjects(numberKeysDict, numberKeysDictCopy, @"Copying mutable dictionary has not produced the same dictionary");
    XCTAssertEqualObjects(stringKeysDict, stringKeysDictCopy, @"Copying mutable dictionary has not produced the same dictionary");
    
    [self checkDictionaryWithNumberKeys:numberKeysDictCopy order:ordering];
    
    [self checkDictionaryWithStringKeys:stringKeysDictCopy order:ordering];
    
    numberKeysDictCopy = [NSMutableDictionary dictionaryWithDictionary:numberKeysDict];
    stringKeysDictCopy = [NSMutableDictionary dictionaryWithDictionary:stringKeysDict];
    
    // These should be equal as its asking a dictionary if an ordered dictionary is equal to it
    XCTAssertEqualObjects(numberKeysDictCopy, numberKeysDict, @"These should be equal as its asking a dictionary if an ordered dictionary is equal to it");
    XCTAssertEqualObjects(stringKeysDictCopy, stringKeysDict, @"These should be equal as its asking a dictionary if an ordered dictionary is equal to it");
    
    // These should be NOT equal as its asking a ordered dictionary if an dictionary is equal to it
    XCTAssertNotEqualObjects(numberKeysDict, numberKeysDictCopy, @"These should be NOT equal as its asking a ordered dictionary if an dictionary is equal to it");
    XCTAssertNotEqualObjects(stringKeysDict, stringKeysDictCopy, @"These should be NOT equal as its asking a ordered dictionary if an dictionary is equal to it");
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
