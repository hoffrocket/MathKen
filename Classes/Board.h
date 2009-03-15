//
//  Board.h
//  MathKen
//
//  Created by Jonathan Hoffman on 3/13/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerBox : NSObject {
	char x;
	char y;
	NSMutableArray *siblings;
	char operation;
	int sum;
	char actualValue;
	char currentGuess;
	NSMutableArray *notes;
}
-(id)initWithX: (int)x yCoord: (int) y value: (int) value;
-(BOOL) setCurrentGuess: (int) guess;
-(void) addNote: (NSNumber *) note;
-(BOOL) isCorrectGuess;
-(int) guess;

@property (nonatomic, retain) NSMutableArray *siblings;
@property (nonatomic, retain) NSMutableArray *notes;


@end

@interface Board : NSObject {
	NSMutableArray *gameBoard;
	int dimension;
}
-(BOOL) setGuessForXCoord: (int) x yCoord: (int) y guess: (int) guess;
-(BOOL) isCorrectXCoord: (int) x yCoord: (int) y;
-(int) valueAtX: (int) x yCoord: (int) y;

-(id) initWithDimension: (int) dimension;
-(int) dimension;

@property (nonatomic, retain) NSMutableArray *gameBoard;

@end
