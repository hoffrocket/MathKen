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


-(void) testCreateBoardWithLayout
{
  NSString * layout = @"4\n"
											@"6 * 0 4\n"
											@"3 + 1 2\n"
											@"3 - 3 7\n"
											@"2 / 8 9\n"
											@"7 + 5 6\n"
											@"7 + 12 13\n"
											@"3 - 10 14\n"
											@"6 * 11 15\n";
	Board * board = [Board createBoardWithLayout:layout];
	STAssertEquals(4,[board dimension], @"Dimension should be same as in layout");
	
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
