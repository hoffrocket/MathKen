//
//  MathKenViewController.m
//  MathKen
//
//  Created by Jonathan Hoffman on 2/22/09.
//  Copyright Goldman Sachs 2009. All rights reserved.
//

#import "MathKenViewController.h"

@implementation MathKenViewController


 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
	 // Create a MathKen View to embed later with a dummy rect for now.
	 mathKenView = [[MathKenView	alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	 mathKenView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	 mathKenView.backgroundColor = [UIColor whiteColor];
	 self.view = mathKenView;
 }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[mathKenView release];
    [super dealloc];
}

@end
