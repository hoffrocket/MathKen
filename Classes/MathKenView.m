//
//  MathKenView.m
//  MathKen
//
//  Created by Jonathan Hoffman on 3/8/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import "MathKenView.h"
#import "Board.h"

@implementation MathKenView

- (id) initWithFrame:(CGRect)rect dimension: (NSInteger)dimension{
	self = [super initWithFrame:rect];
	if (self != nil) {
		NSLog(@"Insantiated the MathKenView");
		
		//timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/30)
	     //   target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
		board = [[Board alloc] initWithDimension:dimension];
	    
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	//CGContextClearRect(context, rect);

	int dimension = [board dimension];
	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 0.3);
	CGContextSetLineWidth(context, 1.0);
	float startX = 10.0;
	
	float size = floor((rect.size.width - (2*startX))/dimension);
	float startY = (rect.size.height - (dimension * size)) / 2;
	
	CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);

	CGContextSelectFont(context, "Helvetica", 200/dimension, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
	CGAffineTransform xform = CGAffineTransformMake(
						1.0,  0.0, 
						0.0, -1.0, 
						0.0,  0.0);
	
    CGContextSetTextMatrix(context, xform);

	for (int i = 0 ; i < dimension; i++) {
		for (int j = 0; j < dimension; j++) {
			float rectX = (i*size)+startX;
			float rectY = (j* size)+startY;
			bool wasTouched = false;
			if (lastTouchPoint.x > rectX && lastTouchPoint.x < rectX + size && 
				lastTouchPoint.y > rectY && lastTouchPoint.y < rectY + size) {
				
				wasTouched = true;
			}
			

			CGContextStrokeRect(context, CGRectMake(rectX, rectY, size,size));
			
			if (wasTouched) {
				CGContextSetLineWidth(context, 3.0);
				CGContextSetRGBStrokeColor(context,0.0, 125.0, 124.0, 1.0);
#define TOUCHED_RECT 1
				CGContextStrokeRect(context, CGRectMake(rectX+TOUCHED_RECT, rectY+TOUCHED_RECT, size-(2*TOUCHED_RECT),size-(2*TOUCHED_RECT)));
				CGContextSetLineWidth(context, 1.0);
				CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 0.3);
				if (lastGuess > 0)
				{
					[board setGuessForXCoord:i yCoord:j guess:lastGuess];
				}
			}
			int guess = [board valueAtX:i yCoord:j];
			if (guess > 0) {
				NSString * text = [[NSNumber numberWithInt: guess] stringValue];
				if ([board isCorrectXCoord:i yCoord:j])
				{
						CGContextSetRGBFillColor(context, 0.0, 0.0, 255.0, 1.0);
				}
				else
				{
					CGContextSetRGBFillColor(context, 255.0, 0.0, 0.0, 1.0);
				}
				CGContextShowTextAtPoint(context, rectX + (size*.38), rectY + (size/3)*2, [text UTF8String], [text length]);
			}
		}
		
	}
  lastGuess = 0;
	
}

- (void) numberGuessed:(NSInteger) guess
{
	lastGuess = guess;
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	
	lastTouchPoint = [touch locationInView:self];
	[self setNeedsDisplay];
}
- (void)dealloc {
	[board release];
	[super dealloc];
}

@end
 
