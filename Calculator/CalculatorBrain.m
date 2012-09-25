//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Niels Jørgen Bagger on 24/09/12.
//  Copyright (c) 2012 Niels Jørgen Bagger. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain

- (void)performWaitingOperation
{
    if ([waitingOperation isEqual:@"+"]) {
        operand = operand + waitingOperand;
    } else if ([waitingOperation isEqual:@"-"]) {
        operand = waitingOperand - operand;
    } else if ([waitingOperation isEqual:@"*"]) {
        operand = operand * waitingOperand;
    } else if ([waitingOperation isEqual:@"/"]) {
        if (operand) {
            operand = waitingOperand / operand;
        }
    }
}
- (void)setOperand:(double)anOperand
{
    operand = anOperand;
}

- (double)performOperation:(NSString*)anOperation
{
    if ([anOperation isEqual:@"sqrt"]) {
        operand = sqrt(operand);
    } else {
        [self performWaitingOperation];
        waitingOperand = operand;
        waitingOperation = anOperation;
    }
    
    return operand;
}

@end
