//
//  MathKenAppDelegate.h
//  MathKen
//
//  Created by Jonathan Hoffman on 2/22/09.
//  Copyright Jonathan Hoffman 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MathKenViewController;

@interface MathKenAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MathKenViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MathKenViewController *viewController;

@end

