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

@synthesize board, layout;
-(id) initWithLayout:(NSString *) alayout
{
	self = [super init];
	if (self != nil)
	{
		layout = alayout;
	}
	return self;
}
-(NSArray *) createSolution
{

	
	return nil;
}
-(bool)isSolutionUnique: (Board *)board
{
	return FALSE;
}

-(void) dealloc
{
	[layout release];
	[super dealloc];
}

@end
