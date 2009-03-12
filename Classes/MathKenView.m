//
//  MathKenView.m
//  MathKen
//
//  Created by Jonathan Hoffman on 3/8/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import "MathKenView.h"
#import "GridCreator.h"

@implementation MathKenView

- (id) initWithFrame:(CGRect)rect {
	self = [super initWithFrame:rect];
	if (self != nil) {
		NSLog(@"Insantiated the MathKenView");
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	NSLog(@"inside drawRect");
	CGContextRef context = UIGraphicsGetCurrentContext();
	/**
	
	// Drawing with a white stroke color
	
	// And drawing with a blue fill color
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
	// Draw them with a 2.0 stroke width so they are a bit more visible.
	CGContextSetLineWidth(context, 2.0);
	
	// Add Rect to the current path, then stroke it
	CGContextAddRect(context, CGRectMake(30.0, 30.0, 60.0, 60.0));
	CGContextStrokePath(context);
	
	// Stroke Rect convenience that is equivalent to above
	CGContextStrokeRect(context, CGRectMake(30.0, 120.0, 60.0, 60.0));
	
	// Stroke rect convenience equivalent to the above, plus a call to CGContextSetLineWidth().
	CGContextStrokeRectWithWidth(context, CGRectMake(30.0, 210.0, 60.0, 60.0), 10.0);
	// Demonstate the stroke is on both sides of the path.
	CGContextSaveGState(context);
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextStrokeRectWithWidth(context, CGRectMake(30.0, 210.0, 60.0, 60.0), 2.0);
	CGContextRestoreGState(context);
	
	CGRect rects[] = 
	{
		CGRectMake(120.0, 30.0, 60.0, 60.0),
		CGRectMake(120.0, 120.0, 60.0, 60.0),
		CGRectMake(120.0, 210.0, 60.0, 60.0),
	};
	// Bulk call to add rects to the current path.
	CGContextAddRects(context, rects, sizeof(rects)/sizeof(rects[0]));
	CGContextStrokePath(context);
	
	// Create filled rectangles via two different paths.
	// Add/Fill path
	CGContextAddRect(context, CGRectMake(210.0, 210.0, 60.0, 60.0));
	CGContextFillPath(context);
	// Fill convienience.
	CGContextFillRect(context, CGRectMake(210.0, 300.0, 60.0, 60.0));
	 */
	int dimension = 4;
	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 0.3);
	CGContextSetLineWidth(context, 1.0);
	float startX = 10.0;
	
	GridCreator * gridCreator = [[GridCreator alloc] init];
	
	NSArray *grid = [gridCreator newBoardWithDimension: dimension];
	[gridCreator release];
	
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
			CGContextStrokeRect(context, CGRectMake(rectX, rectY, size,size));
			NSString * text = [[[grid objectAtIndex:j] objectAtIndex:i] stringValue];
			CGContextShowTextAtPoint(context, rectX + (size*.38), rectY + (size/3)*2, [text UTF8String], [text length]);
		}
		
	}
	
}


- (void)dealloc {
    [super dealloc];
}

@end
 
