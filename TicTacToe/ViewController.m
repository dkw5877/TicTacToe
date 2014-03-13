//
//  ViewController.m
//  TicTacToe
//
//  Created by user on 3/13/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *myLabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *myLabelThree;
@property (weak, nonatomic) IBOutlet UILabel *myLabelFour;
@property (weak, nonatomic) IBOutlet UILabel *myLabelFive;
@property (weak, nonatomic) IBOutlet UILabel *myLabelSix;
@property (weak, nonatomic) IBOutlet UILabel *myLabelSeven;
@property (weak, nonatomic) IBOutlet UILabel *myLabelEight;
@property (weak, nonatomic) IBOutlet UILabel *myLabelNine;
@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureReconizer
{
    if(tapGestureReconizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint tappedPoint = [tapGestureReconizer locationInView:self.view];
        UILabel *labelTapped = [self findLabelUsingPoint:tappedPoint];
        
        if ([labelTapped.text isEqualToString:@""])
        {
            labelTapped.text = self.whichPlayerLabel.text;
            [self setLabelTextColorAndPlayerTurn:labelTapped];
        }
    }
}


//use fast enumeration
-(UILabel *)findLabelUsingPoint:(CGPoint)point
{
    
    for (UILabel *label in self.view.subviews)
    {
        if(CGRectContainsPoint(label.frame, point))
           {
               return label;
           }
    }
    return nil;
}



- (void)setLabelTextColorAndPlayerTurn:(UILabel *)label
{

        if([self.whichPlayerLabel.text isEqualToString:@"x"])
        {
            label.textColor = [UIColor blueColor];
            self.whichPlayerLabel.text = @"o";
        }
        else
        {
            label.textColor =  [UIColor redColor];
            self.whichPlayerLabel.text = @"x";
        }
    
}


@end
