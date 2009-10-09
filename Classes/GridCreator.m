//
//  GridCreator.m
//  MathKen
//
//  Created by Jonathan Hoffman on 3/11/09.
//  Copyright 2009 Jonathan Hoffman. All rights reserved.
//

#import "GridCreator.h"
#import "NSArray+Shuffle.h"


@implementation GridCreator
-(BOOL) meetsGridConstraints:(NSArray *) grid row:(NSArray *) row {
	for (NSArray *aRow in grid) {
		for (NSUInteger i = 0; i < [aRow count]; i++)
		{
			if ([aRow objectAtIndex:i] == [row objectAtIndex: i ])
				return FALSE;
		}
	}
	return TRUE;
}

-(NSArray *) boardWithDimension: (int) size {
	NSMutableArray *grid = [NSMutableArray arrayWithCapacity: size];
	for (int i = 0; i < size; i++){
		NSMutableArray *row = [NSMutableArray arrayWithCapacity: size];
		for (int j = 1; j <= size; j++) {
			[row addObject: [NSNumber numberWithInt:j]];
		}
		NSArray * rowToAdd = row;
		do {
			rowToAdd = [rowToAdd shuffledArray];
		} while (![self meetsGridConstraints: grid row: rowToAdd]);
		[grid addObject: rowToAdd];
	}
	return grid;
}
@end
