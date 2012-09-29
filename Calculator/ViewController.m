//
//  ViewController.m
//  Calculator
//
//  Created by Niels Jørgen Bagger on 24/09/12.
//  Copyright (c) 2012 Niels Jørgen Bagger. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

{
    BOOL userHasPressedDigit;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    stack = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (CalculatorBrain *) brain
{
    if (!brain) {
        brain = [[CalculatorBrain alloc] init];
    }
    return brain;
}

- (void)addTextToStack:(NSString *)text {
    if ([stack text].length > 0) {
        [stack setText:[[stack text] stringByAppendingString:@" "]];
    }
    [stack setText:[[stack text] stringByAppendingString:text]];
}

- (void)pushOperand:(double)operand {
    [self addTextToStack:[NSString stringWithFormat:@"%g", operand]];
    [[self brain] pushOperand:operand];

}

- (void)appendedEquals:(BOOL)on {
    NSRange range = [[stack text] rangeOfString:@" ="];
    if (on && range.location == NSNotFound) {
        [self addTextToStack:@" ="];
    } else if (!on && range.location != NSNotFound) {
        [stack setText:[[stack text] substringToIndex:(range.location - 1)]];
    }
}

- (void)resetStack {
    [stack setText:@""];
}

- (double)performOperation:(NSString *)operation {
    [self appendedEquals:NO];
    [self addTextToStack:operation];
    [self appendedEquals:YES];
    return [[self brain] performOperation:operation];
}

- (IBAction)digitSelected:(UIButton *)sender
{
    [self appendedEquals:NO];
    NSString *digit = [[sender titleLabel] text];
    if (!userIsInTheMiddleOfTypingANumber) {
        if ([digit isEqualToString:@"."]) {
            [display setText:@"0"];
        } else {
            [display setText:@""];
        }
        userIsInTheMiddleOfTypingANumber = YES;
    }
    if ((![digit isEqualToString:@"."]) || (!userHasPressedDigit)) {
        [display setText:[[display text] stringByAppendingString:digit]];
    }
    userHasPressedDigit |= [digit isEqualToString:@"."];
}

- (IBAction)clearPressed:(UIButton *)sender
{
    [self resetStack];
    [display setText:@"0"];
    userHasPressedDigit = NO;
    userIsInTheMiddleOfTypingANumber = NO;
    [[self brain] clear];
}

- (IBAction)deletePressed:(UIButton *)sender {
    int numberOfDigits = [[display text] length];
    if ([[display text] characterAtIndex:(numberOfDigits-1)] == '.') {
        userHasPressedDigit = NO;
    }
    if (numberOfDigits <= 1) {
        [display setText:@"0"];
        userIsInTheMiddleOfTypingANumber = NO;
    } else {
        [display setText:[[display text] substringToIndex:--numberOfDigits]];
    }
}

- (IBAction)enterPressed:(UIButton *)sender
{
    [self pushOperand:[[display text] doubleValue]];
    userIsInTheMiddleOfTypingANumber = NO;
    userHasPressedDigit = NO;
}

- (IBAction)operationSelected:(UIButton *)sender
{
    if (userIsInTheMiddleOfTypingANumber) {
        [self pushOperand:[[display text] doubleValue]];
        userIsInTheMiddleOfTypingANumber = NO;
        userHasPressedDigit = NO;
    }
    NSString * operation = [[sender titleLabel] text];
    double result = [self performOperation:operation];
    [display setText:[NSString stringWithFormat:@"%g", result]];
}

- (IBAction)chsPressed:(UIButton *)sender {
    if (userIsInTheMiddleOfTypingANumber) {
        NSRange range = [[display text] rangeOfString:@"-"];
        if (range.location == NSNotFound)
            [display setText:[@"-" stringByAppendingString:[display text]]];
        else
            [display setText:[[display text] substringFromIndex:1]];
    } else {
        [self operationSelected:sender];
    }
}
@end
