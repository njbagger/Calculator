//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Niels Jørgen Bagger on 24/09/12.
//  Copyright (c) 2012 Niels Jørgen Bagger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
{
    double operand;
    double waitingOperand;
    NSString* waitingOperation;
}

- (void)setOperand:(double)anOperand;
- (double)performOperation:(NSString*)anOperation;

@end
