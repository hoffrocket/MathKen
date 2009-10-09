//
//  MathKenView.m
//  MathKen
//
//  Created by Jonathan Hoffman on 3/8/09.
//  Copyright 2009 Jonathan Hoffman. All rights reserved.
//

#import "MathKenView.h"
#import "Board.h"

@implementation MathKenView

@synthesize activeCell,inputView;

- (id) initWithFrame:(CGRect)rect dimension: (NSInteger)dimension{
	self = [super initWithFrame:rect];
	if (self != nil) {
		NSLog(@"Instantiated the MathKenView");
		
		board = [[Board alloc] initWithDimension:dimension];

		NSLog(@"Finished Instantiated the MathKenView");
	}
	return self;
}

-(void) layoutSubviews
{
	[super layoutSubviews];
	CGRect rect = [self bounds];

	
	NSInteger dimension = [board dimension];
	float startX = 10.0;
	
	float size = floor((rect.size.width - (2*startX))/dimension);
	float startY = 10;

	for(int i = 0; i < dimension; i++)
	{
		for (int j=0; j<dimension; j++)
		{
			float rectX = (i*size)+startX;
			float rectY = (j* size)+startY;
			MKCell *cell = [[MKCell alloc] initWithFrame: CGRectMake(rectX, rectY, size, size) board: board atX: i atY: j];
			[cell addTarget:self action: @selector(cellSelected:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:cell];
		}
	}
	
	inputView = [[MKFloatingInputView alloc] initWithCallBackRecevier:self dimension: dimension];
	inputView.hidden = YES;
	
	[self addSubview:inputView];

}

-(void)cellSelected:(id)sender
{
	if(activeCell != nil)
	{
		[activeCell toggleSelected];
	}
	activeCell = sender;
	inputView.hidden = NO;
	
	[activeCell toggleSelected];
}
- (void) numberGuessed:(NSInteger) guess
{
	if (activeCell != nil)
	{
		[activeCell guess: guess];
	}
	inputView.hidden = YES;
}

- (void)dealloc {
	[board release];
	if (activeCell != nil)
	{
		[activeCell release];
	}
	[inputView release];
	[super dealloc];
}

@end
 
