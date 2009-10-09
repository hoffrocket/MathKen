//
//  MKSolver.h
//  MathKen
//
//  Created by Jonathan Hoffman on 3/20/09.
//  Copyright 2009 Jonathan Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"
@interface MKSolver : NSObject
-(BOOL)isSolutionUnique: (Board *)board;
-(NSArray *) solveFromLayout: (NSString *) layout;
-(NSArray *) solveFromBoard: (Board *) board;
-(NSArray *) solveFromConstraintMap: (NSMutableDictionary *) constraintMap dimension: (NSInteger) dimension;
@end
