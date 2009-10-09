//
//  MKCell.m
//  MathKen
//
//  Created by Jonathan Hoffman on 3/15/09.
//  Copyright 2009 Jonathan Hoffman. All rights reserved.
//

#import "MKCell.h"


@implementation MKCell
@synthesize  board;

-(void) delloc {
	

	[board release];
	[super dealloc];
}

-(id) initWithFrame:  (CGRect) frame board: (Board *) gameBoard atX: (NSInteger)i  atY: (NSInteger)j
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		board = gameBoard;
		x = i;
		y = j;
	}
	return self;
}

- (void)drawRect:(CGRect)rect 
{
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, rect);
	
	CGContextSetRGBFillColor(context, 255.0,255.0, 255.0, 1.0);
	CGContextFillRect(context, rect);


  CGContextSetTextDrawingMode(context, kCGTextFill);
	CGAffineTransform xform = CGAffineTransformMake(
						1.0,  0.0, 
						0.0, -1.0, 
						0.0,  0.0);
	
	CGContextSetTextMatrix(context, xform);

	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 0.3);
	CGContextSetLineWidth(context, 1.0);		

	CGContextStrokeRect(context, rect);
	
	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
	CGContextSetLineWidth(context, 3.0);
	
	if (![board hasTop:x Y:y] && ![board hasLeft:x Y:y])
	{
		CGContextSelectFont(context, "Helvetica", 72/[board dimension], kCGEncodingMacRoman);
		CGContextSetRGBFillColor(context, 0.0,0.0, 0.0, 1.0);
		NSString * goalText = [NSString stringWithFormat:@"%ld %@", (long)[board sumFor:x Y:y],[board operationFor:x Y:y]];
		CGContextShowTextAtPoint(context, rect.origin.x + 5.0, rect.origin.y + 15.0, 
														 [goalText UTF8String], [goalText length]);
	}
	if (![board hasTop:x Y:y])
	{
		CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
		CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
		CGContextStrokePath(context);
	}
	if (![board hasBottom:x Y:y])
	{
		CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
		CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
		CGContextStrokePath(context);
	}
	if (![board hasLeft:x Y:y])
	{
		CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
		CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
		CGContextStrokePath(context);
	}	if (![board hasRight:x Y:y])
	{
		CGContextMoveToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
		CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y  + rect.size.height);
		CGContextStrokePath(context);
	}
			
	if (selected) {
		CGContextSetLineWidth(context, 3.0);
		CGContextSetRGBStrokeColor(context,0.0, 125.0, 124.0, 1.0);
#define TOUCHED_RECT 1
		CGContextStrokeRect(context, CGRectMake(rect.origin.x+TOUCHED_RECT, rect.origin.y+TOUCHED_RECT, rect.size.width-(2*TOUCHED_RECT),rect.size.height-(2*TOUCHED_RECT)));
		CGContextSetLineWidth(context, 1.0);
		CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 0.3);
	}
	
	int guess = [board valueAtX:x yCoord:y];
	if (guess > 0) {
		NSString * text = [[NSNumber numberWithInt: guess] stringValue];
		if ([board isCorrectXCoord:x yCoord:y])
		{
				CGContextSetRGBFillColor(context, 0.0, 0.0, 255.0, 1.0);
		}
		else
		{
			CGContextSetRGBFillColor(context, 255.0, 0.0, 0.0, 1.0);
		}
			CGContextSelectFont(context, "Helvetica", 200/[board dimension], kCGEncodingMacRoman);
		CGContextShowTextAtPoint(context, rect.origin.x + (rect.size.width*.38), rect.origin.y + (rect.size.height/3)*2, [text UTF8String], [text length]);
	}	
	
}


-(void) guess:(NSInteger) guess 
{
	[board setGuessForXCoord:x yCoord:y guess:guess];
	[self setNeedsDisplay];
}
-(void) toggleHint:(NSInteger)hint
{
	
}
-(void)toggleSelected
{
	selected = !selected;
	[self setNeedsDisplay];
}
@end
