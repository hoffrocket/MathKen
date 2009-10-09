//
//  MathKenViewController.m
//  MathKen
//
//  Created by Jonathan Hoffman on 2/22/09.
//  Copyright Jonathan Hoffman 2009. All rights reserved.
//

#import "MathKenViewController.h"

@implementation MathKenViewController

@synthesize mathKenView;



- (void) createMathKenViewWithDimension: (NSInteger) dimension
{
	if (mathKenView != nil)
	{
		[mathKenView removeFromSuperview];
		[mathKenView release];
	}
	mathKenView = [[MathKenView	alloc] initWithFrame:boardRegion.frame dimension: dimension];
	mathKenView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	mathKenView.backgroundColor = [UIColor whiteColor];
	
	[self.view addSubview: mathKenView];
}

 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)viewDidLoad {
	 [boardRegion removeFromSuperview];
	 
	 [self createMathKenViewWithDimension: 4];
 }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (IBAction)newGameAction:(id)sender
{
	UIActionSheet *styleAlert =
	[[UIActionSheet alloc] initWithTitle:@"Choose a Board:"
															delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
										 otherButtonTitles:@"4 x 4", @"6 x 6", nil, nil];
	
	// use the same style as the nav bar
	styleAlert.actionSheetStyle = self.navigationController.navigationBar.barStyle;
	
	[styleAlert showInView:self.view];
	[styleAlert release];
}


// change the navigation bar style, also make the status bar match with it
- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
		{
			[self createMathKenViewWithDimension: 4];
			break;
		}
		case 1:
		{
			[self createMathKenViewWithDimension: 6];
			break;
		}

	}
}

- (void)dealloc {
	[mathKenView release];
	[super dealloc];
}

@end
