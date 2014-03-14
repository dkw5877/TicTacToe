//
//  ViewController.m
//  TicTacToe
//
//  Created by user on 3/13/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "ViewController.h"

#define PLAYER1 @"X"
#define PLAYER2 @"O"

@interface ViewController () <UIAlertViewDelegate>
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

@property (nonatomic, weak)NSString *currentPlayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentPlayer = PLAYER1;
    self.whichPlayerLabel.text = [NSString stringWithFormat:@"Current Player: %@",self.currentPlayer];
    
	// Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureReconizer
{
    if(tapGestureReconizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint tappedPoint = [tapGestureReconizer locationInView:self.view];
        UILabel *labelTapped = [self findLabelUsingPoint:tappedPoint];
        
        if ([labelTapped.text isEqualToString:@""] && labelTapped.tag == 123)
        {
            labelTapped.text = self.currentPlayer;
            
            if([self whoWon])
            {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Game end" message:@"You won!" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Start new game", nil];
                [alertView show];
                return;
            }
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

        if([self.currentPlayer isEqualToString:PLAYER1])
        {
            label.textColor = [UIColor blueColor];
            self.currentPlayer = @"O";
            self.whichPlayerLabel.text = [NSString stringWithFormat:@"Current Player: %@",self.currentPlayer];
        }
        else
        {
            label.textColor =  [UIColor redColor];
            self.currentPlayer = @"X";
            self.whichPlayerLabel.text = [NSString stringWithFormat:@"Current Player: %@",self.currentPlayer];
        }
    
}

- (NSString *) whoWon
{

    //top row for X
    if ([self.myLabelOne.text isEqualToString:@"X"]&&
        [self.myLabelTwo.text isEqualToString:@"X"]&&
        [self.myLabelThree.text isEqualToString:@"X"])
    {
        return @"X";
        
    }
    //middle row for X
    else if([self.myLabelFour.text isEqualToString:@"X"]&&
        [self.myLabelFive.text isEqualToString:@"X"]&&
        [self.myLabelSix.text isEqualToString:@"X"])
    {
        return @"X";
    }

    //bottom row for X
    else if ([self.myLabelSeven.text isEqualToString:@"X"]&&
        [self.myLabelEight.text isEqualToString:@"X"]&&
        [self.myLabelNine.text isEqualToString:@"X"])
    {
        return @"X";
    }
      //first columnn for X
    else if ([self.myLabelOne.text isEqualToString:@"X"]&&
        [self.myLabelFour.text isEqualToString:@"X"]&&
        [self.myLabelSeven.text isEqualToString:@"X"])
    {
        return @"X";
    }
    //second column for X
    else if ([self.myLabelTwo.text isEqualToString:@"X"]&&
        [self.myLabelFive.text isEqualToString:@"X"]&&
        [self.myLabelEight.text isEqualToString:@"X"])
    {
        return @"X";
    }
    //third column for X
    else if ([self.myLabelThree.text isEqualToString:@"X"]&&
        [self.myLabelSix.text isEqualToString:@"X"]&&
        [self.myLabelNine.text isEqualToString:@"X"])
    {
        return @"X";
    }
    else if ([self.myLabelOne.text isEqualToString:@"O"]&&
             [self.myLabelTwo.text isEqualToString:@"O"]&&
             [self.myLabelThree.text isEqualToString:@"O"])
    {
        return @"O";
    }
    //second row for O
    else if([self.myLabelFour.text isEqualToString:@"O"]&&
            [self.myLabelFive.text isEqualToString:@"O"]&&
            [self.myLabelSix.text isEqualToString:@"O"])
    {
        return @"O";
    }
    
    //third row for O
    else if ([self.myLabelSeven.text isEqualToString:@"O"]&&
             [self.myLabelEight.text isEqualToString:@"O"]&&
             [self.myLabelNine.text isEqualToString:@"O"])
    {
        return @"O";
    }
    //first columnn for O
    else if ([self.myLabelOne.text isEqualToString:@"O"]&&
             [self.myLabelFour.text isEqualToString:@"O"]&&
             [self.myLabelSeven.text isEqualToString:@"O"])
    {
        return @"O";
    }
    //second column for O
    else if ([self.myLabelTwo.text isEqualToString:@"O"]&&
             [self.myLabelFive.text isEqualToString:@"O"]&&
             [self.myLabelEight.text isEqualToString:@"O"])
    {
        return @"O";
    }
    //third column for O
    else if ([self.myLabelThree.text isEqualToString:@"O"]&&
             [self.myLabelSix.text isEqualToString:@"O"]&&
             [self.myLabelNine.text isEqualToString:@"O"])
    {
        return @"O";
    }
    //diagonal for o
    else if ([self.myLabelOne.text isEqualToString:@"O"]&&
             [self.myLabelFive.text isEqualToString:@"O"]&&
             [self.myLabelNine.text isEqualToString:@"O"])
    {
        
        return @"O";
    }
    
    //diagonal for o
    else if ([self.myLabelThree.text isEqualToString:@"O"]&&
             [self.myLabelFive.text isEqualToString:@"O"]&&
             [self.myLabelSeven.text isEqualToString:@"O"])
    {
        return @"O";
    }
    
    //diagonal for x
    else if ([self.myLabelOne.text isEqualToString:@"O"]&&
             [self.myLabelFive.text isEqualToString:@"O"]&&
             [self.myLabelNine.text isEqualToString:@"O"])
    {
        return @"O";
    }
    
    //diagonal for x
    else if ([self.myLabelThree.text isEqualToString:@"O"]&&
             [self.myLabelFive.text isEqualToString:@"O"]&&
             [self.myLabelSeven.text isEqualToString:@"O"])
    {
        
        //[alertView show];
        return @"O";
    }
    else
    {
        return nil;
    }

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self startNewGame];
    }
}

- (void)startNewGame
{
    self.currentPlayer = PLAYER1;
    self.whichPlayerLabel.text = self.whichPlayerLabel.text = [NSString stringWithFormat:@"Current Player: %@",self.currentPlayer];

    
    for (UILabel * label in self.view.subviews) {
       if(label.tag == 123)
       {
           label.text = @"";
       }
    }
    
}

    
@end
