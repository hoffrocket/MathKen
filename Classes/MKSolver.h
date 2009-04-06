//
//  MKSolver.h
//  MathKen
//
//  Created by Jonathan Hoffman on 3/20/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"

@interface MKSolver : NSObject {
	Board * board;
	NSString * layout;
}
-(id) initWithLayout:(NSString *) layout;
-(NSArray *) createSolution;
@property(nonatomic, retain) Board *board;
@property(nonatomic, retain) NSString *layout;
@end
