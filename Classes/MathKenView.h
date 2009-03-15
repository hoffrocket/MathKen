//
//  MathKenView.h
//  MathKen
//
//  Created by Jonathan Hoffman on 3/8/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"

@interface MathKenView : UIView {
	NSTimer * timer;
	Board * board;
	CGPoint lastTouchPoint;
	NSInteger lastGuess;
}
- (id) initWithFrame:(CGRect)rect dimension: (NSInteger)dimension;
- (void) numberGuessed:(NSInteger) guess;
@end
