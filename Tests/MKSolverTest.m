//
//  MKSolverTest.m
//  MathKen
//
//  Created by Jonathan Hoffman on 4/6/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "MKSolver.h"

@interface MKSolverTest : SenTestCase

@end

@implementation MKSolverTest

+(NSArray *) parseSol: (NSString *) solText
{
	NSArray * lines = [solText componentsSeparatedByString:@"\n"];
	NSMutableArray * solArray = [NSMutableArray arrayWithCapacity:[lines count]];
	
	for (NSString * line in lines) {
		NSArray * digits = [line componentsSeparatedByString:@","];
		NSMutableArray *numArray = [NSMutableArray arrayWithCapacity:[digits count]];
		for (NSString * digitString in digits) {
			[numArray addObject:[NSNumber numberWithInt: [digitString intValue]]];
		}
		[solArray addObject: numArray];
	}
	return [solArray retain];
}
-(void) testSolveFourByFour
{
	NSString * layout = @"4\n"
	@"6 * 0 4\n"
	@"3 + 1 2\n"
	@"3 - 3 7\n"
	@"2 / 8 9\n"
	@"7 + 5 6\n"
	@"7 + 12 13\n"
	@"3 - 10 14\n"
	@"6 * 11 15";
	
	NSString * solText = @"3,1,2,4\n"
											 @"2,4,3,1\n"
											 @"1,2,4,3\n"
											 @"4,3,1,2";
	MKSolver *solver = [[MKSolver alloc] init];
	NSArray * expectedSolution = [NSArray arrayWithObject: [MKSolverTest parseSol: solText]]; 
	NSArray * solution  = [solver solveFromLayout: layout];
	STAssertTrue([expectedSolution isEqualToArray: solution],@"Solution not as expected");
	[solver release];
}

@end
