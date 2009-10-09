//
//  MathKenAppDelegate.m
//  MathKen
//
//  Created by Jonathan Hoffman on 2/22/09.
//  Copyright Jonathan Hoffman 2009. All rights reserved.
//

#import "MathKenAppDelegate.h"
#import "MathKenViewController.h"

@implementation MathKenAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
