//
//  FooTest.m
//  MathKen
//
//  Created by Jonathan Hoffman on 3/11/09.
//  Copyright 2009 Goldman Sachs. All rights reserved.
//

#import "GTMSenTestCase.h"

@interface FooTest : SenTestCase
@end


@implementation FooTest

-(void) testBar {
	
	STAssertEqualStrings(@"foo",@"foo",@"Strings should be equal");
}

@end
