//
//  MathKenViewController.h
//  MathKen
//
//  Created by Jonathan Hoffman on 2/22/09.
//  Copyright Jonathan Hoffman 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MathKenView.h"

@interface MathKenViewController : UIViewController<UIActionSheetDelegate> {
	MathKenView *mathKenView;
	IBOutlet UIView *boardRegion;
}
@property(nonatomic, retain) MathKenView *mathKenView;
- (IBAction)newGameAction:(id)sender;

@end

                           