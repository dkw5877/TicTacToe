//
//  ViewController.m
//  TicTacToe
//
//  Created by user on 3/13/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "ViewController.h"
#import "ComputerBrain.h"

#define PLAYER1 @"X"
#define PLAYER2 @"O"
#define LOWER_TAG 1
#define UPPER_TAG 9

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
@property (weak, nonatomic) IBOutlet UILabel *playerSymbolLabel;

@property (nonatomic, weak)NSString *currentPlayer;
@property(nonatomic, strong)NSMutableArray *gameBoard;
@property(nonatomic, assign)int numberOfMoves;
@property(nonatomic)ComputerBrain *brain;
@property(nonatomic)BOOL singlePlayerMode;
@property(nonatomic)BOOL computersTurn;
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentPlayer = PLAYER1;
    self.playerSymbolLabel.text = PLAYER1;
    self.whichPlayerLabel.text = [NSString stringWithFormat:@"Current Player: %@",self.currentPlayer];
    
    //setup the game board
    self.gameBoard = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++)
    {
        [self.gameBoard addObject:@"-"];
    }
    
    //raise an alert to show game options
    [self raiseNewGameAlert];
    

}


- (IBAction)onUserDrag:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UILabel* targetLabel = nil;
    
    //pan gesture coordinates in the specified view, in this case the view controller
    CGPoint point = [panGestureRecognizer translationInView:self.view];

    self.playerSymbolLabel.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    point.x += self.playerSymbolLabel.center.x;
    point.y += self.playerSymbolLabel.center.y;

    if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        targetLabel = [self findLabelUsingPoint:point];
        
        if (targetLabel) {
    
            targetLabel.text = self.playerSymbolLabel.text;
            
            [self setLabelTextColor:targetLabel];
            [self updateGameBoard:targetLabel.tag withPlayerMove:self.currentPlayer];
            
            if([self whoWon])
            {
                //return the label back to the views original X,Y location (0,0)
                self.playerSymbolLabel.transform = CGAffineTransformMakeTranslation(0, 0);
                
                [self raiseAlert: [NSString stringWithFormat:@"You Won Player %@!",self.currentPlayer]];
                
                return;
            }
            
            //check if there is a tie
            if (self.numberOfMoves >= 9) {
                
                //return the label back to the views original X,Y location (0,0)
                self.playerSymbolLabel.transform = CGAffineTransformMakeTranslation(0, 0);
                
                [self raiseAlert: @"You Tied!"];
                return;
            }
            
            //no win no tie change to next player
            [self changePlayer:self.currentPlayer];
            
            //return the label back to the views original X,Y location (0,0)
            self.playerSymbolLabel.transform = CGAffineTransformMakeTranslation(0, 0);
            
            //reset the gesture recognizer after use
            [panGestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
        }
        
        //return the label back to the views original X,Y location (0,0)
        self.playerSymbolLabel.transform = CGAffineTransformMakeTranslation(0, 0);
        
        //reset the gesture recognizer after use
        [panGestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
        
    }
    
    if (self.singlePlayerMode && [self.currentPlayer isEqualToString:PLAYER2])
    {
        [self startComputersTurn];
        
    }

}


- (IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureReconizer
{
    if(tapGestureReconizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint tappedPoint = [tapGestureReconizer locationInView:self.view];
        UILabel *labelTapped = [self findLabelUsingPoint:tappedPoint];
        
        
        if ([labelTapped.text isEqualToString:@""] && labelTapped.tag >= LOWER_TAG
            && labelTapped.tag <= UPPER_TAG)
        {
            labelTapped.text = self.currentPlayer;
            [self setLabelTextColor:labelTapped];
            [self updateGameBoard:labelTapped.tag withPlayerMove:self.currentPlayer];
            
            if([self whoWon])
            {
                [self raiseAlert: [NSString stringWithFormat:@"You Won Player %@!",self.currentPlayer]];
                return;
            }
            [self changePlayer:self.currentPlayer];
        }
        
        //check if there is a tie
        if (self.numberOfMoves >= 9) {
            [self raiseAlert: @"You Tied!"];
            return;
        }
    }

    
    if (self.singlePlayerMode && [self.currentPlayer isEqualToString:PLAYER2])
    {
        [self startComputersTurn];
        
    }
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView.message isEqualToString:@"Choose player mode"] && buttonIndex==2)
    {
        self.singlePlayerMode = YES;
        //start the computer player
        self.brain = [[ComputerBrain alloc]initWithGameBoard:self.gameBoard andCurrentPlayer:self.currentPlayer];
        self.computersTurn = NO;
    }
    else
    {
        [self startNewGame];
    }
}

#pragma mark - helper methods

/**
 * Determine if one of the nine labels was tapped by the user
 * @param CGPoint point tapped by the user
 * @return UILabel* the label tapped by the use
 */
-(UILabel *)findLabelUsingPoint:(CGPoint)point
{
    for (UILabel *label in self.view.subviews)
    {
        if(CGRectContainsPoint(label.frame, point) &&
           (label.tag >= LOWER_TAG  && label.tag <= UPPER_TAG))
        {
            return label;
        }
    }
    return nil;
}

/**
 * Set the text color based on player and advance the turn to the next player
 * @param UILabel* label
 * @return void
 */
- (void)setLabelTextColor:(UILabel *)label
{
    
    if([self.currentPlayer isEqualToString:PLAYER1])
    {
        label.textColor = [UIColor blueColor];
    }
    else
    {
        label.textColor =  [UIColor redColor];
        
    }
}

/**
 * Change the current players turn to the next player
 * @param NSString player - the current player
 * @return void
 */
-(void)changePlayer:(NSString*)player
{
    if ([player isEqualToString:PLAYER1])
    {
        self.currentPlayer = PLAYER2;
        self.playerSymbolLabel.text = PLAYER2;
        self.playerSymbolLabel.textColor = [UIColor redColor];
        self.whichPlayerLabel.text = [NSString stringWithFormat:@"Current Player: %@",self.currentPlayer];
        
        if (self.singlePlayerMode)
        {
            self.computersTurn = !self.computersTurn;
        }
        
        NSLog(@"computer players turn?: %d", self.computersTurn);

    }
    else
    {
        self.currentPlayer = PLAYER1;
        self.playerSymbolLabel.text = PLAYER1;
        self.playerSymbolLabel.textColor = [UIColor blueColor];
        self.whichPlayerLabel.text = [NSString stringWithFormat:@"Current Player: %@",self.currentPlayer];
        
        NSLog(@"computer players turn?: %d", self.computersTurn);
    }
    
}

/**
 * Update the game board with the players symbol (X or O)
 * @param none
 * @return NSString
 */
- (void)updateGameBoard:(NSInteger)tag withPlayerMove:(NSString *)player
{
    if (tag >= LOWER_TAG && tag <= UPPER_TAG)
    {
        [self.gameBoard replaceObjectAtIndex:tag-1 withObject:player];
        self.numberOfMoves++;
        NSLog(@"game board %@:",self.gameBoard);
    }

}


/**
 * Determine if there was a winner of the game by checking the 8 possible combinations
 * horizontal, vertical and diagonal. Returns the user (X or O) who won the game, or nil
 * if there is no winner at this time
 * @param none
 * @return NSString
 */
-(NSString*)whoWon
{
    NSString *winningPlayer = nil;
    
    //check all the horizontal combinations
    for (int i=0; i< [self.gameBoard count]; i+=3)
    {
       winningPlayer = [self checkTripleWins:self.gameBoard[i] secondLabel:self.gameBoard[i+1] thirdLabel:self.gameBoard[i+2]];
        
        if(winningPlayer != nil)
        {
            return winningPlayer;
        }
    }
    
    //check all the vertical combinations
    for (int i=0; i < 3; i++)
    {
        winningPlayer = [self checkTripleWins:self.gameBoard[i] secondLabel:self.gameBoard[i+3] thirdLabel:self.gameBoard[i+6]];
        
        if(winningPlayer != nil)
        {
            return winningPlayer;
        }
    }

    //check the diagonals
    winningPlayer = [self checkTripleWins:self.gameBoard[0] secondLabel:self.gameBoard[4] thirdLabel:self.gameBoard[8]];
    
    if (winningPlayer != nil)
    {
        return winningPlayer;

    }
    
    winningPlayer = [self checkTripleWins:self.gameBoard[2] secondLabel:self.gameBoard[4] thirdLabel:self.gameBoard[6]];
    
    if (winningPlayer != nil)
    {
        return winningPlayer;
        
    }
    
    return winningPlayer;
}

/**
 * Checks to see if the three labels passed to the method are all selected by either player,
 * if so, then the winning player is returned
 * @param NSString* firstLabel
 * @param NSString* secondLabel
 * @param NSString* thirdLabel
 * @return NSString* player with winning combination or nil if no winning comibination
 */
- (NSString *)checkTripleWins:(NSString*)firstLabel secondLabel:(NSString*)secondLabel thirdLabel:(NSString*)thirdLabel
{
    if ([firstLabel isEqualToString:self.currentPlayer] &&
        [secondLabel isEqualToString:self.currentPlayer] &&
        [thirdLabel isEqualToString:self.currentPlayer]) {
        return self.currentPlayer;
    }
    else
    {
        return nil;
    }
}


/**
 * Let the computer choose a move, and update the game board and screen
 * accordingly.
 * @param none
 * @return void
 */
-(void)startComputersTurn
{
    NSLog(@"computer choosing a move");

    NSLog(@"game board before choice: %@",self.gameBoard);
    NSInteger move = [self.brain makeMove];
    
    //TODO: we need to review all checks, we should not try
    //to choose an already selected location. If we do, lets
    //just try again for now
    while (![self.gameBoard[move] isEqualToString:@"-"])
    {
        move = [self.brain makeMove];
    }
    move++; //computer is choosing an array index, not a label value
    
    NSLog(@"computer chose postion %ld", (long)move);
    
    [self updateGameBoard:move withPlayerMove:self.currentPlayer];
    
    //TODO: we really need to search the labels by tag value to find the
    //correct label to update
    
    for (UILabel* label in self.view.subviews)
    {
        //check that the view is actually a label, and the tag value
        if([label isKindOfClass:[UILabel class]] &&label.tag == move)
        {
            [self setLabelTextColor:label];
            label.text = self.currentPlayer;
        }
    }

    if([self whoWon])
    {
        [self raiseAlert: [NSString stringWithFormat:@"Player %@ Won!",self.currentPlayer]];
        return;
    }
    
    //check if there is a tie
    if (self.numberOfMoves >= 9)
    {
        [self raiseAlert: @"You Tied!"];
        return;
    }
    
    [self changePlayer:self.currentPlayer];
    //self.computersTurn = !self.computersTurn;
    
    
}
/**
 * Start a new gaming be resetting the initial player and clearing the board
 * @param none
 * @return void
 */
- (void)startNewGame
{
    self.currentPlayer = PLAYER1;
    self.numberOfMoves = 0;

    //clear the screen
    for (UILabel * label in self.view.subviews)
    {
       if( [label isKindOfClass:[UILabel class]] &&
          (label.tag >= LOWER_TAG && label.tag <= UPPER_TAG))
       {
           label.text = @"";
       }
    }
    
    self.whichPlayerLabel.text = self.whichPlayerLabel.text = [NSString stringWithFormat:@"Current Player: %@",self.currentPlayer];
    
    //set the symbol label to stating player
    self.playerSymbolLabel.text = PLAYER1;
    
    self.playerSymbolLabel.textColor = [UIColor blueColor];
    
    //reset the game board
    [self.gameBoard removeAllObjects];
    
    for (int i = 0; i < 9; i++)
    {
        [self.gameBoard addObject:@"-"];
    }
}


- (void)raiseAlert:(NSString*)message
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Tic-Tac-Toe" message:message delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Start New Game", nil];
    [alertView show];
}

- (void)raiseNewGameAlert
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Tic-Tac-Toe" message:@"Choose player mode" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Two Player Mode",@"Single Player Mode", nil];
    [alertView show];
}

#pragma mark - old whoWon method using if else

/**
 * Determine if there was a winner of the game
 * @param none
 * @return NSString
 */
//- (NSString *)whoWon
//{
//    //first check all the horizontal rows for a winner, then check the vertical rows
//    //then check the two diagonal rows. We first check if X is a winner, then O
//    if ([self.myLabelOne.text isEqualToString:@"X"]&&
//        [self.myLabelTwo.text isEqualToString:@"X"]&&
//        [self.myLabelThree.text isEqualToString:@"X"])
//    {
//        return @"X";
//        
//    }
//    else if([self.myLabelFour.text isEqualToString:@"X"]&&
//            [self.myLabelFive.text isEqualToString:@"X"]&&
//            [self.myLabelSix.text isEqualToString:@"X"])
//    {
//        return @"X";
//    }
//    else if ([self.myLabelSeven.text isEqualToString:@"X"]&&
//             [self.myLabelEight.text isEqualToString:@"X"]&&
//             [self.myLabelNine.text isEqualToString:@"X"])
//    {
//        return @"X";
//    }
//    //first columnn for X
//    else if ([self.myLabelOne.text isEqualToString:@"X"]&&
//             [self.myLabelFour.text isEqualToString:@"X"]&&
//             [self.myLabelSeven.text isEqualToString:@"X"])
//    {
//        return @"X";
//    }
//    else if ([self.myLabelTwo.text isEqualToString:@"X"]&&
//             [self.myLabelFive.text isEqualToString:@"X"]&&
//             [self.myLabelEight.text isEqualToString:@"X"])
//    {
//        return @"X";
//    }
//    else if ([self.myLabelThree.text isEqualToString:@"X"]&&
//             [self.myLabelSix.text isEqualToString:@"X"]&&
//             [self.myLabelNine.text isEqualToString:@"X"])
//    {
//        return @"X";
//    }
//    else if ([self.myLabelOne.text isEqualToString:@"X"]&&
//             [self.myLabelFive.text isEqualToString:@"X"]&&
//             [self.myLabelNine.text isEqualToString:@"X"])
//    {
//        return @"X";
//    }
//    else if ([self.myLabelThree.text isEqualToString:@"X"]&&
//             [self.myLabelFive.text isEqualToString:@"X"]&&
//             [self.myLabelSeven.text isEqualToString:@"X"])
//    {
//        return @"X";
//    }
//    else if ([self.myLabelOne.text isEqualToString:@"O"]&&
//             [self.myLabelTwo.text isEqualToString:@"O"]&&
//             [self.myLabelThree.text isEqualToString:@"O"])
//    {
//        return @"O";
//    }
//    else if([self.myLabelFour.text isEqualToString:@"O"]&&
//            [self.myLabelFive.text isEqualToString:@"O"]&&
//            [self.myLabelSix.text isEqualToString:@"O"])
//    {
//        return @"O";
//    }
//    else if ([self.myLabelSeven.text isEqualToString:@"O"]&&
//             [self.myLabelEight.text isEqualToString:@"O"]&&
//             [self.myLabelNine.text isEqualToString:@"O"])
//    {
//        return @"O";
//    }
//    else if ([self.myLabelOne.text isEqualToString:@"O"]&&
//             [self.myLabelFour.text isEqualToString:@"O"]&&
//             [self.myLabelSeven.text isEqualToString:@"O"])
//    {
//        return @"O";
//    }
//    else if ([self.myLabelTwo.text isEqualToString:@"O"]&&
//             [self.myLabelFive.text isEqualToString:@"O"]&&
//             [self.myLabelEight.text isEqualToString:@"O"])
//    {
//        return @"O";
//    }
//    else if ([self.myLabelThree.text isEqualToString:@"O"]&&
//             [self.myLabelSix.text isEqualToString:@"O"]&&
//             [self.myLabelNine.text isEqualToString:@"O"])
//    {
//        return @"O";
//    }
//    else if ([self.myLabelOne.text isEqualToString:@"O"]&&
//             [self.myLabelFive.text isEqualToString:@"O"]&&
//             [self.myLabelNine.text isEqualToString:@"O"])
//    {
//        
//        return @"O";
//    }
//    else if ([self.myLabelThree.text isEqualToString:@"O"]&&
//             [self.myLabelFive.text isEqualToString:@"O"]&&
//             [self.myLabelSeven.text isEqualToString:@"O"])
//    {
//        return @"O";
//    }
//    else if ([self.myLabelOne.text isEqualToString:@"O"]&&
//             [self.myLabelFive.text isEqualToString:@"O"]&&
//             [self.myLabelNine.text isEqualToString:@"O"])
//    {
//        return @"O";
//    }
//    else if ([self.myLabelThree.text isEqualToString:@"O"]&&
//             [self.myLabelFive.text isEqualToString:@"O"]&&
//             [self.myLabelSeven.text isEqualToString:@"O"])
//    {
//        return @"O";
//    }
//    else
//    {
//        return nil;
//    }
//    
//}



    
@end
