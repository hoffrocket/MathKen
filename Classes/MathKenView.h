//
//  MathKenView.h
//  MathKen
//
//  Created by Jonathan Hoffman on 3/8/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "MKCell.h"
#import "MKFloatingInputView.h"

@interface MathKenView : UIView {
	NSTimer * timer;
	Board * board;
	MKCell * activeCell;
	MKFloatingInputView *inputView;
}

- (id) initWithFrame:(CGRect)rect dimension: (NSInteger)dimension;
- (void) numberGuessed:(NSInteger) guess;
- (void) cellSelected:(id)sender;

@property (nonatomic, retain) MKCell * activeCell;
@property (nonatomic, retain) MKFloatingInputView * inputView;
@end
