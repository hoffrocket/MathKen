//
//  MKCell.h
//  MathKen
//
//  Created by Jonathan Hoffman on 3/15/09.
//  Copyright 2009 Jonathan Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"

@interface MKCell : UIControl {
	Board *board;
	NSInteger x;
	NSInteger y;
	BOOL selected;
}

@property(nonatomic, retain) Board *board;

-(id) initWithFrame:  (CGRect) frame board: (Board *) gameBoard atX: (NSInteger)i  atY: (NSInteger)j;
-(void) guess:(NSInteger) guess;
-(void) toggleHint:(NSInteger)hint;
-(void) toggleSelected;
@end
