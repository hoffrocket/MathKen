//
//  MKSolver.m
//  MathKen
//
//  Created by Jonathan Hoffman on 3/20/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import "MKSolver.h"
#import "Board.h"
@implementation MKSolver

-(BOOL)isSolutionUnique: (Board *)board
{
	NSArray *solutions = [self solveFromBoard:board];
	return [solutions count] == 1;
}

-(NSArray *)solveFromBoard: (Board *) board
{
	NSInteger dimension = [board dimension];
	NSMutableDictionary * constraintMap = [NSMutableDictionary dictionary];
	for (int i = 0; i < dimension; i++)
	{
		for (int j = 0; j < dimension; j++)
		{
			NSNumber *  constraintKey = [NSNumber numberWithInt:(i * dimension) +j];
			if ([constraintMap objectForKey: constraintKey] == nil)
			{
				AnswerBox * answerBox = [board answerBoxAtX:i yCoord:j];
				MKConstraint * mkConstraint = [answerBox constraint];
				NSArray * answerBoxes = [mkConstraint answerBoxes];
				NSMutableArray * answerBoxKeys = [NSMutableArray array];
				for (AnswerBox *box in answerBoxes)
				{
					[answerBoxKeys addObject: [NSNumber numberWithInt: (box.x * dimension) + box.y]];
				}
				NSString *operation = [mkConstraint operation];
				if ([operation length] == 0)
				{
					operation = @"_";
				}
				NSMutableArray * constraint = [NSMutableArray arrayWithObjects:
																			 [NSNumber numberWithInt: [mkConstraint sum]],
																			 operation,
																			 answerBoxKeys, nil];
				for (NSNumber *key in answerBoxKeys)
				{
					[constraintMap setObject:constraint forKey: key];
				}
			}

		}
	}
	return [self solveFromConstraintMap: constraintMap dimension: dimension];
}



#define kOper	1
#define kSum 0
#define kBoxes 2

-(BOOL) isValid: (NSInteger) index guess: (NSInteger) n solution: (NSArray *) solution dimension: (NSInteger) dimension constraintMap: (NSDictionary *) constraintMap
{
	for (int i = 0; i < dimension; i++)
	{
		if (n == [[solution objectAtIndex: index%dimension + (i*dimension)] intValue] || //columns
				n == [[solution objectAtIndex: (index/dimension)*dimension + i] intValue]) //row
		{
			return FALSE;
		}
	}
	NSArray * constraint = [constraintMap objectForKey:[NSNumber numberWithInt:index]];
	NSMutableArray *currentVals = [NSMutableArray arrayWithObject: [NSNumber numberWithInt:n]];
	NSArray * boxes = [constraint objectAtIndex:kBoxes];
	for (NSNumber * box in boxes)
	{
		if (index != [box intValue])
		{
			[currentVals addObject:[solution objectAtIndex: [box intValue]]];
		}
	}
	NSString * operString = [constraint objectAtIndex: kOper];
	if ([operString length] == 0)
	{
		return FALSE;
	}
	char oper = [operString characterAtIndex:0];
	NSInteger sum = [[constraint objectAtIndex:kSum] intValue];
	NSInteger tsum  = 0;
	NSInteger first = 0;
	NSInteger second = 0;
	
	switch (oper) {
		case '_':
			return sum == n;
			break;
		case '+':
			
			for (NSNumber *v in currentVals)
			{
				tsum += [v intValue];
			}
			return tsum == sum || tsum < sum && [currentVals containsObject: [NSNumber numberWithInt:0]];
			break;
		case 'x':
		case '*':
			tsum  = 1;
			for (NSNumber *v in currentVals)
			{
				tsum *= [v intValue];
			}
			return tsum == sum || tsum == 0 && n < sum;
			break;
		case '-':
			
			second = [[currentVals objectAtIndex:1] intValue];
			if (second == 0) return TRUE;
			first= [[currentVals objectAtIndex:0] intValue];
			
			if (first > second)
				return first - second == sum;
			else
				return second - first == sum;
			break;
		case '/':
			second = [[currentVals objectAtIndex:1] intValue];
			if (second == 0) return TRUE;
			first= [[currentVals objectAtIndex:0] intValue];
			
			if (first > second)
				return first / second == sum;
			else
				return second / first == sum;		
			break;
		default:
			return FALSE;
			break;
	}
	return FALSE;
}

-(void) search: (NSUInteger) index currentSolution: (NSMutableArray *) solution dimension: (NSInteger) dimension 
 constraintMap: (NSDictionary *) constraintMap allSolutions: (NSMutableArray *) allSolutions limit: (NSUInteger) limit
{
	if (index == [solution count])
	{
		NSMutableArray * solutionGrid = [NSMutableArray array];
		
		for (int i = 0; i < dimension; i++)
		{
			NSMutableArray * row = [NSMutableArray array];
			for (int j = 0; j < dimension; j++)
			{
				[row addObject:[solution objectAtIndex: i*dimension + j]];
			}
			[solutionGrid addObject: row];
		}
		[allSolutions addObject:solutionGrid];
	}
	else 
	{ 
		for (NSInteger i = 1; i <= dimension; i++)
		{
			//if there is a solution limit, break
			if (limit == 0 || limit > [allSolutions count])
			{
				if ([self isValid: index guess: i solution: solution dimension: dimension constraintMap: constraintMap])
				{
					[solution replaceObjectAtIndex:index withObject: [NSNumber numberWithInt: i]];
					[self search: (index+1) currentSolution:solution dimension:dimension constraintMap: constraintMap allSolutions: allSolutions limit: limit];
					[solution replaceObjectAtIndex:index withObject: [NSNumber numberWithInt: 0]];
				}
			}
		}
	}
}
- (NSArray *) solveFromConstraintMap: (NSMutableDictionary *) constraintMap dimension: (NSInteger) dimension  {
  NSMutableArray * solution = [NSMutableArray array];
	for (NSInteger i = 0; i < dimension*dimension; i++)
	{
		[solution addObject:[NSNumber numberWithInt:0]];
	}
	
	NSMutableArray * allSolutions = [NSMutableArray array];
	[self search:0 currentSolution: solution
		 dimension:dimension constraintMap:constraintMap allSolutions:allSolutions limit:2];
	return [allSolutions retain];

}
-(NSArray *) solveFromLayout: (NSString *) layout
{
	
	NSArray *lines = [layout componentsSeparatedByString:@"\n"];
	NSInteger dimension = [[lines objectAtIndex:0] integerValue];
	
	NSMutableDictionary * constraintMap = [[NSMutableDictionary dictionary] retain];
	for (NSUInteger i = 1; i < [lines count]; i++)
	{
		NSArray *splitLine = [[lines objectAtIndex:i] componentsSeparatedByString:@" "];
		NSRange range;
		range.location = 2;
		range.length = [splitLine count] - 2;
		
		NSMutableArray * constraint = [NSMutableArray arrayWithObjects:
																	 [NSNumber numberWithInt: [[splitLine objectAtIndex:0]integerValue]],
																	 [splitLine objectAtIndex:1],
																	 [splitLine subarrayWithRange: range], nil];
		
		for (NSUInteger j = 2; j < [splitLine count]; j++)
		{
			[constraintMap setObject: constraint forKey:[NSNumber numberWithInt:[[splitLine objectAtIndex:j] integerValue]]];
		}
	}

	return [self solveFromConstraintMap: constraintMap dimension: dimension];

}


@end
