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

//
//-(void)findLabelUsingPoint:(CGPoint)point
//{
//    
//    
//    if (CGRectContainsPoint(self.myLabelOne.frame, point))
//    {
//        if ([self.myLabelOne.text isEqualToString:@""])
//        {
//            self.myLabelOne.text = self.whichPlayerLabel.text;
//            [self setLabelValueAndColorAndPlayer: self.myLabelOne];
//        }
//        
//    }
//    else if(CGRectContainsPoint(self.myLabelTwo.frame, point))
//    {
//        if ([self.myLabelTwo.text isEqualToString:@""])
//        {
//            self.myLabelTwo.text = self.whichPlayerLabel.text;
//            [self setLabelValueAndColorAndPlayer: self.myLabelTwo];
//        }
//    }
//    else if(CGRectContainsPoint(self.myLabelThree.frame, point))
//    {
//        if ([self.myLabelThree.text isEqualToString:@""])
//        {
//            self.myLabelThree.text = self.whichPlayerLabel.text;
//            [self setLabelValueAndColorAndPlayer: self.myLabelThree];
//        }
//    }
//    else if(CGRectContainsPoint(self.myLabelFour.frame, point))
//    {
//        if ([self.myLabelFour.text isEqualToString:@""])
//        {
//            self.myLabelFour.text = self.whichPlayerLabel.text;
//            [self setLabelValueAndColorAndPlayer: self.myLabelFour];
//        }
//    }
//    else if(CGRectContainsPoint(self.myLabelFive.frame, point))
//    {
//        if ([self.myLabelFive.text isEqualToString:@""])
//        {
//            self.myLabelFive.text = self.whichPlayerLabel.text;
//            [self setLabelValueAndColorAndPlayer: self.myLabelFive];
//        }
//    }
//    else if(CGRectContainsPoint(self.myLabelSix.frame, point))
//    {
//        if ([self.myLabelSix.text isEqualToString:@""])
//        {
//            self.myLabelSix.text = self.whichPlayerLabel.text;
//            [self setLabelValueAndColorAndPlayer:self.myLabelSix];
//        }
//    }
//    else if(CGRectContainsPoint(self.myLabelSeven.frame, point))
//    {
//        if ([self.myLabelSeven.text isEqualToString:@""])
//        {
//            self.myLabelSeven.text = self.whichPlayerLabel.text;
//            [self setLabelValueAndColorAndPlayer:self.myLabelSeven];
//        }
//    }
//    else if(CGRectContainsPoint(self.myLabelEight.frame, point))
//    {
//        if ([self.myLabelEight.text isEqualToString:@""])
//        {
//            self.myLabelEight.text = self.whichPlayerLabel.text;
//            [self setLabelValueAndColorAndPlayer:self.myLabelEight];
//        }
//    }
//    else if(CGRectContainsPoint(self.myLabelNine.frame, point))
//    {
//        if ([self.myLabelNine.text isEqualToString:@""])
//        {
//            self.myLabelNine.text = self.whichPlayerLabel.text;
//            [self setLabelValueAndColorAndPlayer:self.myLabelNine];
//        }
//    }
//
//}


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
