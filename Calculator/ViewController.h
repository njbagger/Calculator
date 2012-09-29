//
//  ViewController.h
//  Calculator
//
//  Created by Niels Jørgen Bagger on 24/09/12.
//  Copyright (c) 2012 Niels Jørgen Bagger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface ViewController : UIViewController

{
    CalculatorBrain *brain;
    IBOutlet UILabel *display;
    BOOL userIsInTheMiddleOfTypingANumber;
    IBOutlet UILabel *stack;
    
}

- (IBAction)digitSelected:(UIButton *)sender;
- (IBAction)operationSelected:(UIButton *)sender;
- (IBAction)enterPressed:(UIButton *)sender;
- (IBAction)clearPressed:(UIButton *)sender;
- (IBAction)deletePressed:(UIButton *)sender;
- (IBAction)chsPressed:(UIButton *)sender;

@end
