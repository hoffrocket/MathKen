//
//  NSArray-Shuffle.m
//  MathKen
//
//  Created by Jonathan Hoffman on 3/11/09.
//  Copyright 2009 Jonathan Hoffman. All rights reserved.
//

#import "NSArray+Shuffle.h"


@implementation NSArray(Shuffle)

-(NSArray *) shuffledArray {
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
	
	NSMutableArray *copy = [self mutableCopy];
	while ([copy count] > 0)
	{
		int index = arc4random() % [copy count];
		id objectToMove = [copy objectAtIndex:index];
		[array addObject:objectToMove];
		[copy removeObjectAtIndex:index];
	}
	
	[copy release];
	return array;
}

@end
