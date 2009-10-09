//
//  MKFloatingInputView.h
//  MathKen
//
//  Created by Jonathan Hoffman on 4/7/09.
//  Copyright 2009 Jonathan Hoffman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKFloatingInputView : UIView {
	id callBack;
}
- (id)initWithCallBackRecevier: (id) toCallBack dimension:(NSInteger) dimension;
@property(nonatomic, retain) id callBack;
@end
