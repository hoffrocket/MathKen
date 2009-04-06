//
//  Board.h
//  MathKen
//
//  Created by Jonathan Hoffman on 3/13/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKConstraint :NSObject {
	NSString * operation;
	NSInteger sum;
	
}
-(id) initWithBoxes: (NSArray *) boxes;
+(NSInteger) doSumFor:(char) oper withAnswerBoxes: (NSArray *) boxes;
@property (nonatomic, retain) NSString * operation;
@property (nonatomic) NSInteger sum;
@end

@interface AnswerBox : NSObject {
	MKConstraint * constraint;
	char actualValue;
	char currentGuess;
	NSMutableArray *notes;
}
-(id)initWithValue: (NSInteger) value;
-(BOOL) setCurrentGuess: (NSInteger) guess;
-(void) addNote: (NSNumber *) note;
-(BOOL) isCorrectGuess;
-(NSInteger) guess;

@property (nonatomic, retain) NSMutableArray *notes;
@property (nonatomic, retain) MKConstraint * constraint;
@property (nonatomic) char actualValue;
@end



@interface Board : NSObject {
	NSMutableArray *gameBoard;
	NSInteger dimension;
}
+(Board *) createBoardWithLayout: (NSString *) layout;
-(BOOL) setGuessForXCoord: (NSInteger) x yCoord: (NSInteger) y guess: (NSInteger) guess;
-(BOOL) isCorrectXCoord: (NSInteger) x yCoord: (NSInteger) y;
-(NSInteger) valueAtX: (NSInteger) x yCoord: (NSInteger) y;

-(id) initWithDimension: (NSInteger) dimension;
-(id) initWithBoard: (NSMutableArray *) board;
-(NSInteger) dimension;
-(BOOL) hasTop: (NSInteger) x Y: (NSInteger) y;
-(BOOL) hasBottom: (NSInteger) x Y: (NSInteger) y;
-(BOOL) hasLeft: (NSInteger) x Y: (NSInteger) y;
-(BOOL) hasRight: (NSInteger) x Y: (NSInteger) y;
-(NSString *) operationFor:(NSInteger) x Y: (NSInteger)y;
-(NSInteger) sumFor: (NSInteger) x Y: (NSInteger)y;
@property (nonatomic, retain) NSMutableArray *gameBoard;

@end
