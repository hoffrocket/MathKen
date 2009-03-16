//
//  MathKenViewController.m
//  MathKen
//
//  Created by Jonathan Hoffman on 2/22/09.
//  Copyright Goldman Sachs 2009. All rights reserved.
//

#import "MathKenViewController.h"

@implementation MathKenViewController

@synthesize mathKenView, buttons;

-(id)init
{
	self = [super init];
	if (self != nil)
	{
		buttons = [[NSMutableArray alloc] init];
	}
	return self;
}

#define DIMENSION 6

 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
	 // Create a MathKen View to embed later with a dummy rect for now.
	 mathKenView = [[MathKenView	alloc] initWithFrame:[UIScreen mainScreen].applicationFrame dimension: DIMENSION];
	 mathKenView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	 mathKenView.backgroundColor = [UIColor whiteColor];
	 float size = 40.0;
	 float spacing = 10.0;
	 float span = size*DIMENSION + (DIMENSION - 1) * spacing;
	 float startX = mathKenView.frame.size.width/2 - span/2;
	 for (int i=0; i < DIMENSION; i++)
	 {
		 UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		 button.frame = CGRectMake(startX, 390.0, size, size);
		 startX += size + spacing;
		 [button setTitle:[NSString stringWithFormat:@"%ld",(long)(i+1)] forState:UIControlStateNormal];

		 [button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
		 [buttons addObject:button];
		 [button setNeedsDisplay];
		 [mathKenView addSubview:button];
	 }
	 self.view = mathKenView;
 }

-(void)numberButtonClicked:(id)sender
{
	NSLog(@"Number button was clicked with value %@",[sender currentTitle]);
	[mathKenView numberGuessed: [[sender currentTitle] intValue]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[mathKenView release];
	[buttons release];
	[super dealloc];
}

@end
