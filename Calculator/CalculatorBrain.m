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

- (void)clear {
    [[self operandStack] removeAllObjects];
}

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
        double denominator = [self popOperand];
        if (divider == 0)
            operand = 0;
        else
            operand = denominator / divider;
    } else if ([anOperation isEqual:@"sqrt"]) {
        double value = [self popOperand];
        operand = (value < 0 ? 0 : sqrt(value));
    } else if ([anOperation isEqual:@"sin"]) {
        operand = sin([self popOperand]);
    } else if ([anOperation isEqual:@"cos"]) {
        operand = cos([self popOperand]);
    } else if ([anOperation isEqual:@"CHS"]) {
        operand = -1 * ([self popOperand]);
    } else if ([anOperation isEqual:@"π"]) {
        operand = M_PI;
    }
    [self pushOperand:operand];
    return operand;
}

@end
