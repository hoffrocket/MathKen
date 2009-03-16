//
//  BoardTest.m
//  MathKen
//
//  Created by Jonathan Hoffman on 3/14/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "Board.h"


@interface BoardTest : SenTestCase
@end


@implementation BoardTest

-(void) testMathConstraints 
{
	int dim = 4;
	Board * board = [[Board alloc] initWithDimension:dim];

	AnswerBox * box = [board answerBoxAtX:i yCoord:y];

	
	
	[board release];
}
-(void) testBoard
{
	int dim = 4;
	Board * board = [[Board alloc] initWithDimension:dim];
	for (int i = 0; i < dim; i++)
	{
		
		for(int j = 0; j < dim; j++)
		{
			STAssertEquals(0, [board valueAtX:i yCoord:j], @"All values should be 0");
		}
	}
	[board release];
}
@end
