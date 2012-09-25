//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Niels Jørgen Bagger on 24/09/12.
//  Copyright (c) 2012 Niels Jørgen Bagger. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;

@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (double)popOperand
{
    NSNumber *operandObject = [[self operandStack] lastObject];
    if (operandObject) [[self operandStack] removeLastObject];
    return [operandObject doubleValue];
}
- (void)pushOperand:(double)anOperand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:anOperand];
    [self.operandStack addObject:operandObject];
}

- (double)performOperation:(NSString*)anOperation
{
    if ([anOperation isEqual:@"+"]) {
        operand = [self popOperand] + [self popOperand];
    } else if ([anOperation isEqual:@"-"]) {
        double subtrahend = [self popOperand];
        operand = [self popOperand] - subtrahend;
    } else if ([anOperation isEqual:@"*"]) {
        operand = [self popOperand] * [self popOperand];
    } else if ([anOperation isEqual:@"/"]) {
        double divider = [self popOperand];
        operand = [self popOperand] / divider;
    } else if ([anOperation isEqual:@"sqrt"]) {
        operand = sqrt([self popOperand]);
    }
    [self pushOperand:operand];
    return operand;
}

@end
