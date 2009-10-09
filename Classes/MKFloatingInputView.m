//
//  MKFloatingInputView.m
//  MathKen
//
//  Created by Jonathan Hoffman on 4/7/09.
//  Copyright 2009 Jonathan Hoffman. All rights reserved.
//

#import "MKFloatingInputView.h"



@implementation MKFloatingInputView

-(void)createSubViews: (NSInteger) dimension
{
	
	CGRect rect = [self bounds];
	NSLog(@"Inside of layoutSubViews");
	float size = 40.0;
	float spacing = 10.0;
	//float span = size*DIMENSION + (DIMENSION - 1) * spacing;
	float startX = rect.origin.x;
	for (int i=0; i < dimension; i++)
	{
		UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		button.frame = CGRectMake(startX, rect.origin.y, size, size);
		startX += size + spacing;
		[button setTitle:[NSString stringWithFormat:@"%ld",(long)(i+1)] forState:UIControlStateNormal];
		
		[button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
		[button setNeedsDisplay];
		button.opaque = NO;
		button.backgroundColor = [UIColor clearColor];
		[self addSubview:button];
	}
}

- (id)initWithCallBackRecevier: (id) toCallBack dimension: (NSInteger)dimension {
		CGRect frame = CGRectMake(15,315,300,40);
	
    if (self = [super initWithFrame:frame]) {
			self.opaque = NO;
			callBack = toCallBack;
			[self createSubViews: dimension];
    }
    return self;
}



-(void)numberButtonClicked:(id)sender
{

	NSLog(@"Number button was clicked with value %@",[sender currentTitle]);

	[callBack numberGuessed: [[sender currentTitle] intValue]];
}

- (void)drawRect:(CGRect)rect {
	

}

@synthesize callBack;
- (void)dealloc {
	[super dealloc];
}


@end
