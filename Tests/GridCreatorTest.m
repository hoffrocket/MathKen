//
//  FooTest.m
//  MathKen
//
//  Created by Jonathan Hoffman on 3/11/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "GridCreator.h"

@interface GridCreatorTest : SenTestCase
	
@end


@implementation GridCreatorTest



-(void) testGridCreator {
	GridCreator * gridCreator = [[GridCreator alloc] init];
	NSUInteger expectedCount = 4;
	NSArray * shuffledGrid = [gridCreator boardWithDimension: expectedCount];
	NSUInteger shuffleGridCount =  [shuffledGrid count];
	STAssertEquals(expectedCount,shuffleGridCount, @"Unexpected count");
	for (NSUInteger i = 0; i < shuffleGridCount ; i++){
		NSArray * row = [shuffledGrid objectAtIndex:i];
		NSUInteger rowCount = [row count];
		STAssertEquals(expectedCount,rowCount, @"Unexpected count");
	}
	[gridCreator release];
}

@end
