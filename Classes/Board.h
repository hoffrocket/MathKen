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
	NSArray * answerBoxes;
}
-(id) initWithBoxes: (NSArray *) boxes;
+(NSInteger) doSumFor:(char) oper withAnswerBoxes: (NSArray *) boxes;
@property (nonatomic, retain) NSString * operation;
@property (nonatomic, retain) NSArray * answerBoxes;
@property (nonatomic) NSInteger sum;
@end

@interface AnswerBox : NSObject {
	MKConstraint * constraint;
	char actualValue;
	char currentGuess;
	NSMutableArray *notes;
	NSInteger x;
	NSInteger y;
}
-(id)initWithValue: (NSInteger) value X: (NSInteger)xValue Y: (NSInteger)yValue;
-(BOOL) setCurrentGuess: (NSInteger) guess;
-(void) addNote: (NSNumber *) note;
-(BOOL) isCorrectGuess;
-(NSInteger) guess;

@property (nonatomic, retain) NSMutableArray *notes;
@property (nonatomic, retain) MKConstraint * constraint;
@property (nonatomic) char actualValue;
@property (nonatomic) NSInteger x;
@property (nonatomic) NSInteger y;
@end



@interface Board : NSObject {
	NSMutableArray *gameBoard;
	NSInteger dimension;
}
+(Board *) createBoardWithLayout: (NSString *) layout;
-(BOOL) setGuessForXCoord: (NSInteger) x yCoord: (NSInteger) y guess: (NSInteger) guess;
-(BOOL) isCorrectXCoord: (NSInteger) x yCoord: (NSInteger) y;
-(NSInteger) valueAtX: (NSInteger) x yCoord: (NSInteger) y;
-(AnswerBox *) answerBoxAtX: (NSInteger) x yCoord:(NSInteger)y;
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
