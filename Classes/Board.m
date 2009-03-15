//
//  Board.m
//  MathKen
//
//  Created by Jonathan Hoffman on 3/13/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import "Board.h"
#import "GridCreator.h"

@implementation AnswerBox

-(id)initWithX: (int)xVal yCoord: (int) yVal value: (int) value {
	self = [super init];
	if (self != nil) {
		x = xVal;
		y = yVal;
		actualValue = value;
		siblings = [[NSMutableArray alloc] init];
		notes = [[NSMutableArray alloc] init];
		
	}
	return self;
}
-(BOOL) setCurrentGuess: (int) guess {
	currentGuess = guess;
	return [self isCorrectGuess];
}
-(BOOL) isCorrectGuess {
	return currentGuess == actualValue;
}
-(int) guess {
	return currentGuess; 
}
-(void) addNote: (NSNumber *) note {
	[notes addObject:note];
}

@synthesize siblings;
@synthesize notes;

-(void) dealloc {
	[siblings release];
	[notes release];
	[super dealloc];
}

@end

@implementation Board
-(id) initWithDimension: (int) dimensionParam {
	self = [super init];
	if (self != nil) {
		dimension = dimensionParam;
		GridCreator * gridCreator = [[GridCreator alloc] init];
		NSArray *gridValues = [gridCreator boardWithDimension: dimension];
		[gridCreator release];
		gameBoard = [[NSMutableArray alloc] initWithCapacity: dimension];
		for (int i = 0; i < dimension; i++) {
			NSMutableArray *gameRow = [NSMutableArray arrayWithCapacity:dimension];
			NSArray *gridRow = [gridValues objectAtIndex:i];
			for (int j=0; j < dimension; j++) {
				AnswerBox *answerBox = [[AnswerBox alloc] initWithX:i yCoord: j value: [[gridRow objectAtIndex:j] intValue]];
				[gameRow addObject: answerBox];
				[answerBox release];
			}
			[gameBoard addObject: gameRow];
		}
	}
	return self;
}

@synthesize gameBoard;
-(void) dealloc {
	[gameBoard release];
	[super dealloc];
}

-(AnswerBox *) answerBoxAtX: (int) x yCoord:(int)y {
	return [[gameBoard objectAtIndex:x]objectAtIndex:y];
}
-(BOOL) setGuessForXCoord: (int) x yCoord: (int) y guess: (int) guess {
	AnswerBox *answerBox = [self answerBoxAtX:x yCoord: y];
	return [answerBox setCurrentGuess:guess];
}
-(BOOL) isCorrectXCoord: (int) x yCoord: (int) y{
	AnswerBox *answerBox = [self answerBoxAtX:x yCoord: y];
	return [answerBox isCorrectGuess];
}
-(int) valueAtX: (int) x yCoord: (int) y {
	AnswerBox *answerBox = [self answerBoxAtX:x yCoord: y];
	return [answerBox guess];
}
-(int) dimension {
	return dimension;
}



@end
