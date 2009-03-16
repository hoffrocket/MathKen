//
//  Board.m
//  MathKen
//
//  Created by Jonathan Hoffman on 3/13/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import "Board.h"
#import "GridCreator.h"
#import "NSArray+Shuffle.h"

@implementation AnswerBox

-(id)initWithValue: (NSInteger) value {
	self = [super init];
	if (self != nil) {
		actualValue = value;
		notes = [[NSMutableArray alloc] init];
	}
	return self;
}
-(BOOL) setCurrentGuess: (NSInteger) guess {
	currentGuess = guess;
	return [self isCorrectGuess];
}
-(BOOL) isCorrectGuess {
	return currentGuess == actualValue;
}
-(NSInteger) guess {
	return currentGuess; 
}
-(void) addNote: (NSNumber *) note {
	[notes addObject:note];
}

@synthesize constraint,notes, actualValue;

-(void) dealloc {
	[constraint release];
	[notes release];
	[super dealloc];
}

@end


@implementation MKConstraint

-(id) initWithBoxes: (NSArray *) boxes
{
	self = [super init];
	if (self != nil)
	{
		
		NSArray * shuffledBoxes = [boxes shuffledArray];

		if ([shuffledBoxes count] == 1)
		{
			operation = @"";
			sum = [[shuffledBoxes objectAtIndex:0] actualValue];
		}
		else
		{
			NSMutableArray *availableOps = [NSMutableArray array];
			[availableOps addObject:@"+"];
			[availableOps addObject:@"x"];
			if ([shuffledBoxes count] == 2)
			{
				[availableOps addObject:@"-"];
				[availableOps addObject:@"-"];
				int valOne = [[shuffledBoxes objectAtIndex:0] actualValue];
				int valTwo = [[shuffledBoxes objectAtIndex:1] actualValue];
				if ((valOne > valTwo && valOne % valTwo == 0) || (valTwo > valOne && valTwo % valOne == 0))
				{
					[availableOps addObject:@"/"];
					[availableOps addObject:@"/"];
				}
			}
			operation = [availableOps objectAtIndex: arc4random() % [availableOps count]];
			sum = [MKConstraint doSumFor:[operation characterAtIndex:0] withAnswerBoxes: shuffledBoxes];
		}
		
	}
	return self;
}

+(NSInteger) doSumFor:(char) oper withAnswerBoxes: (NSArray *) shuffledBoxes
{
	int tSum = 0;
	if (oper == '+')
	{

		for (AnswerBox *box in shuffledBoxes)
		{
			tSum += [box actualValue];
		}

	}
	if (oper == 'x')
	{
		tSum = 1;
		for (AnswerBox *box in shuffledBoxes)
		{
			tSum *= [box actualValue];
		}
	}
	if (oper == '/')
	{
		int valOne = [[shuffledBoxes objectAtIndex:0] actualValue];
		int valTwo = [[shuffledBoxes objectAtIndex:1] actualValue];

		return valOne > valTwo ? valOne / valTwo : valTwo / valOne;
	}
	if (oper == '-')
	{
		int valOne = [[shuffledBoxes objectAtIndex:0] actualValue];
		int valTwo = [[shuffledBoxes objectAtIndex:1] actualValue];
		return valOne > valTwo ? valOne - valTwo : valTwo - valOne;
	}
	return tSum;
}

@synthesize operation, sum;

@end


@implementation Board

-(AnswerBox *) answerBoxAtX: (NSInteger) x yCoord:(NSInteger)y {
	return [[gameBoard objectAtIndex:x]objectAtIndex:y];
}

-(id) initWithDimension: (NSInteger) dimensionParam {
	self = [super init];
	if (self != nil) {
		dimension = dimensionParam;
		GridCreator * gridCreator = [[GridCreator alloc] init];
		NSArray *gridValues = [gridCreator boardWithDimension: dimension];
		[gridCreator release];
		gameBoard = [[NSMutableArray alloc] initWithCapacity: dimension];
		

		NSMutableArray *wasSeen = [[NSMutableArray alloc] initWithCapacity: dimension];
		for (int i = 0; i < dimension; i++) {
			NSMutableArray *gameRow = [NSMutableArray arrayWithCapacity:dimension];
			NSMutableArray *wasSeenRow = [NSMutableArray arrayWithCapacity:dimension];
			[wasSeen addObject: wasSeenRow];
			NSArray *gridRow = [gridValues objectAtIndex:i];
			for (int j=0; j < dimension; j++) {
				AnswerBox *answerBox = [[AnswerBox alloc] initWithValue: [[gridRow objectAtIndex:j] intValue]];
				[gameRow addObject: answerBox];
				[answerBox release];
				[wasSeenRow addObject:[[NSNumber numberWithBool:false]retain]];
			}
			[gameBoard addObject: gameRow];
		}
	

		for (int i = 0; i < dimension; i++) {
			for (int j=0; j < dimension; j++) {
				
				if(![[[wasSeen objectAtIndex:i] objectAtIndex:j] boolValue])
				{

					NSMutableArray *boxes = [NSMutableArray array];

					NSArray * firstCell = [[NSArray alloc]  initWithObjects: [NSNumber numberWithInt:i], [NSNumber numberWithInt:j], nil];
					NSMutableArray *adjacents = [NSMutableArray arrayWithObject: firstCell];
					[firstCell release];
					int cSize = (arc4random() % (dimension <= 4 ? dimension - 1 : 4)) +1;
					while (cSize > 0 && [adjacents count] > 0)
					{
						NSArray *cell = [adjacents objectAtIndex:(arc4random() % [adjacents count])];
						int cI = [[cell objectAtIndex:0]intValue];
						int cJ = [[cell objectAtIndex:1]intValue];
						
						AnswerBox *box = [self answerBoxAtX:cI yCoord: cJ];
						[boxes addObject:box];
						[[wasSeen objectAtIndex:cI] replaceObjectAtIndex:cJ withObject: [NSNumber numberWithBool:true]];
						NSLog(@"Visiting box %d, %d", cI, cJ);
						
						adjacents = [NSMutableArray array];
						
						if (cI> 0 && ![[[wasSeen objectAtIndex:cI - 1] objectAtIndex:cJ] boolValue])
						{
							[adjacents addObject: [NSArray arrayWithObjects: [NSNumber numberWithInt:cI-1], [NSNumber numberWithInt:cJ], nil]];
						}
						if (cI < dimension - 1 && ![[[wasSeen objectAtIndex:cI + 1] objectAtIndex:cJ] boolValue])
						{
							[adjacents addObject: [NSArray arrayWithObjects: [NSNumber numberWithInt:cI+1], [NSNumber numberWithInt:cJ], nil]];
						}
						if (cJ < 0 && ![[[wasSeen objectAtIndex:cI ] objectAtIndex:cJ - 1] boolValue])
						{
							[adjacents addObject: [NSArray arrayWithObjects: [NSNumber numberWithInt:cI], [NSNumber numberWithInt:cJ - 1], nil]];
						}
						if (cJ < dimension - 1 && ![[[wasSeen objectAtIndex:cI] objectAtIndex:cJ+1] boolValue])
						{
							[adjacents addObject: [NSArray arrayWithObjects: [NSNumber numberWithInt:cI], [NSNumber numberWithInt:cJ + 1], nil]];
						}
						cSize --;
					}
					
					MKConstraint * constraint = [[MKConstraint alloc]initWithBoxes:boxes];
					for (AnswerBox *box in boxes)
					{

						box.constraint = constraint;
					}
					[constraint release];

				}
				AnswerBox *box = [self answerBoxAtX:i yCoord: j];
				NSLog(@"%ld,%ld will have constraint %ld %@", (long)i, (long)j, (long)box.constraint.sum, box.constraint.operation);
			}
		}
		[wasSeen release];
	}
	return self;
}

@synthesize gameBoard;
-(void) dealloc {
	[gameBoard release];
	[super dealloc];
}


-(BOOL) setGuessForXCoord: (NSInteger) x yCoord: (NSInteger) y guess: (NSInteger) guess {
	AnswerBox *answerBox = [self answerBoxAtX:x yCoord: y];
	return [answerBox setCurrentGuess:guess];
}
-(BOOL) isCorrectXCoord: (NSInteger) x yCoord: (NSInteger) y{
	AnswerBox *answerBox = [self answerBoxAtX:x yCoord: y];
	return [answerBox isCorrectGuess];
}
-(NSInteger) valueAtX: (NSInteger) x yCoord: (NSInteger) y {
	AnswerBox *answerBox = [self answerBoxAtX:x yCoord: y];
	return [answerBox guess];
}
-(NSInteger) dimension {
	return dimension;
}

-(BOOL) hasTop: (NSInteger) x Y: (NSInteger) y
{

	if (y == 0) return FALSE;
	return [self answerBoxAtX:x yCoord: y].constraint == [self answerBoxAtX:x yCoord: y - 1].constraint;
	
}

-(BOOL) hasBottom: (NSInteger) x Y: (NSInteger) y
{
	if (y >= dimension -1 ) return FALSE;
	return [self answerBoxAtX:x yCoord: y].constraint == [self answerBoxAtX:x yCoord: y + 1].constraint;
}
-(BOOL) hasLeft: (NSInteger) x Y: (NSInteger) y
{
	if (x == 0 ) return FALSE;
	return [self answerBoxAtX:x yCoord: y].constraint == [self answerBoxAtX:x -1 yCoord: y].constraint;
}
-(BOOL) hasRight: (NSInteger) x Y: (NSInteger) y{
	if (x >= dimension - 1 ) return FALSE;
	return [self answerBoxAtX:x yCoord: y].constraint == [self answerBoxAtX:x +1 yCoord: y].constraint;
}
-(NSString *) operationFor:(NSInteger) x Y: (NSInteger)y{
		return [self answerBoxAtX:x yCoord: y].constraint.operation;
}
-(NSInteger) sumFor: (NSInteger) x Y: (NSInteger)y{
		return [self answerBoxAtX:x yCoord: y].constraint.sum;
}

@end
