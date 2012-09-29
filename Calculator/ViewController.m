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

- (void)resetStack {
    [stack setText:@""];
}

- (double)performOperation:(NSString *)operation {
    [self addTextToStack:operation];
    return [[self brain] performOperation:operation];
}

- (IBAction)digitSelected:(UIButton *)sender
{
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
@end
