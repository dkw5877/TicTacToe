//
//  ComputerBrain.m
//  TicTacToe
//
//  Created by user on 3/14/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "ComputerBrain.h"

@interface ComputerBrain()

@property(nonatomic, strong)NSMutableArray *gameBoard;
@property (nonatomic, weak)NSString *currentPlayer;
@property (nonatomic, weak)NSString *opposingPlayer;
@property(nonatomic)BOOL simple;
@property(nonatomic)BOOL goodPlayer;
@end

@implementation ComputerBrain


- (id)init
{
    self = [super init];
    return self;
}

/**
 * Create the computer brain with a reference to the gameboard from the view controller class
 * @param NSMutableArray gameBoard
 * @return id instance of ComputerBrain
 */

- (id)initWithGameBoard:(NSMutableArray*)gameBoard
{
    self = [self init];
    _gameBoard = gameBoard;
    self.simple = YES;
    
    return self;
}

/**
 * Create the computer brain with a reference to the gameboard from the view controller class
 * @param NSMutableArray gameBoard
 * @return id instance of ComputerBrain
 */
- (id)initWithGameBoard:(NSMutableArray*)gameBoard andCurrentPlayer:(NSString*)player
{
    self = [self init];
    _gameBoard = gameBoard;
    self.simple = NO;
    
    
    if ([player isEqualToString:@"X"])
    {
        self.currentPlayer = @"O";
        self.opposingPlayer = @"X";
    }
    else
    {
        self.currentPlayer = @"X";
        self.opposingPlayer = @"O";
    }

    return self;
}

-(NSInteger)makeMove
{
    self.simple = NO;
    if (self.simple) {
        return [self makeSimpleMoveUsingRandomNumber:self.gameBoard];
    }
    else
    {
        return [self makeStrategicMoveUsingLogic];
    }
}

/**
 *
 *
 *
 */
-(NSInteger)makeSimpleMoveUsingRandomNumber:(NSMutableArray*)gameBoard
{
    NSInteger randomNumber = arc4random() % 9;
    
    //check if the selected spot in the array is already occupied,
    //if so pick another number
    while (![gameBoard[randomNumber]isEqualToString:@"-"])
    {
        //choose a new random number
        randomNumber =arc4random() % 9;
    }
    return randomNumber;
}

-(NSInteger)makeStrategicMoveUsingLogic
{
    NSInteger move =  [self canPlayertWin:self.currentPlayer];
    
    if (move != -1) {
        return move;
    }
    
    
    move = [self canPlayertWin:self.opposingPlayer];
    if (move != -1)
    {
        return move;
    }
    
    //check if center is not occupied, if not choose it
    move = [self isCenterOpen];
    
    if(move != -1)
    {
        return move;
    }
    
    move = [self chooseSomeCorner];
    
    if(move != -1)
    {
        return move;
    }

    move = [self makeSimpleMoveUsingRandomNumber:self.gameBoard];
    return move;

}


/**
 *
 *
 *
 */
-(NSInteger)canPlayertWin:(NSString*)player
{
    //check all the horizontal combinations
    for (int i=0; i < [self.gameBoard count]; i+=3)
    {
        if ([self.gameBoard[i]isEqualToString:player] &&
            [self.gameBoard[i+1]isEqualToString:player] &&
            [self.gameBoard[i+2]isEqualToString:@"-"])
        {
            //self.gameBoard[i+2] = self.currentPlayer;
            return i+2;
        }
    }
    
    for (int i=1; i < [self.gameBoard count]; i+=3)
    {
        if ([self.gameBoard[i]isEqualToString:player] &&
            [self.gameBoard[i+1]isEqualToString:player] &&
            [self.gameBoard[i-1]isEqualToString:@"-"])
        {
            //self.gameBoard[i-1] = self.currentPlayer;
            return i-1;
        }
    }
    
    for (int i=0; i < [self.gameBoard count]; i+=3)
    {
        if ([self.gameBoard[i]isEqualToString:player] &&
            [self.gameBoard[i+2]isEqualToString:player] &&
            [self.gameBoard[i+1]isEqualToString:@"-"])
        {
            //self.gameBoard[i+1] = self.currentPlayer;
            return i+1;
        }
    }
  
    
    //check all the vertical combinations
    for (int i=0; i < 3; i++)
    {
        if ([self.gameBoard[i]isEqualToString:player] &&
            [self.gameBoard[i+3]isEqualToString:player] &&
            [self.gameBoard[i+6]isEqualToString:@"-"])
        {
            //self.gameBoard[i+6] = self.currentPlayer;
            return i+6;
        }
    }
    
    //split pair
    for (int i=0; i < 3; i++)
    {
        if ([self.gameBoard[i]isEqualToString:player] &&
            [self.gameBoard[i+6]isEqualToString:player] &&
            [self.gameBoard[i+3]isEqualToString:@"-"])
        {
            //self.gameBoard[i+3] = self.currentPlayer;
            return i+3;
        }
    }
    
    //second pair
    for (int i=0; i < 3; i++)
    {
        if ([self.gameBoard[i+3]isEqualToString:player] &&
            [self.gameBoard[i+6]isEqualToString:player] &&
            [self.gameBoard[i]isEqualToString:@"-"])
        {
            //self.gameBoard[i] = self.currentPlayer;
            return i;
        }
    }
    
    //check the diagonal top left to bottom right
//    for (int i = 0; i < 9; i++)
//    {
//        int firstItem = [self elementAtRow:i andColumn:i];
//        
//        
//        int secondItem = [self elementAtRow:i+1 andColumn:i+1];
//        
//        if ([self.gameBoard[i]isEqualToString:player] &&
//            [self.gameBoard[i+1]isEqualToString:player])
//        {
//            return i;
//        }
//    }
    
    
    //check the diagonal top left to bottom right
    if([self.gameBoard[0]isEqualToString:player] &&
       [self.gameBoard[4]isEqualToString:player] &&
       [self.gameBoard[8]isEqualToString:@"-"])
    {
        return 8;
    }
    
    if([self.gameBoard[4]isEqualToString:player] &&
       [self.gameBoard[8]isEqualToString:player] &&
       [self.gameBoard[0]isEqualToString:@"-"])
    {
        return 0;
    }
    
    if ([self.gameBoard[0]isEqualToString:player] &&
        [self.gameBoard[8]isEqualToString:player] &&
        [self.gameBoard[4]isEqualToString:@"-"])
    {
        return 4;
    }
    
    //check the diagonal top right to bottom left
    if([self.gameBoard[2]isEqualToString:player] &&
       [self.gameBoard[4]isEqualToString:player] &&
       [self.gameBoard[6]isEqualToString:@"-"])
    {
        return 6;
    }
    
    if([self.gameBoard[4]isEqualToString:player] &&
       [self.gameBoard[6]isEqualToString:player] &&
       [self.gameBoard[2]isEqualToString:@"-"])
    {
        return 2;
    }
    
    if ([self.gameBoard[2]isEqualToString:player] &&
        [self.gameBoard[6]isEqualToString:player] &&
        [self.gameBoard[4]isEqualToString:@"-"])
    {
        return 4;
    }
    
    return -1;
}


/**
 *
 *
 *
 */
-(NSInteger)chooseSomeCorner
{
    if ([self.gameBoard[0] isEqualToString:@"-"]) {
        return 0;
    }
    else if ([self.gameBoard[2]isEqualToString:@"-"])
    {
        return 2;
    }
    else if ([self.gameBoard[6] isEqualToString:@"-"])
    {
        return 6;
    }
    else if ([self.gameBoard[8] isEqualToString:@"-"])
    {
        return 8;
    }
    else
    {
        return -1;
    }
}

-(NSInteger)isCenterOpen
{
    //center is index 4 of the game board
    if ([self.gameBoard[4] isEqualToString:@"-"])
    {
        return 4;
    }
    
    return -1;
}


/**
 * Use row major ordering to find the specific element in the array
 * that is being accessed based on row and column
 * @param int row
 * @param int column
 * @return NSString value at position row,column
 */
-(NSString *)elementAtRow:(int)row andColumn:(int)column
{
    return self.gameBoard[row * [self.gameBoard count]+column];
}






//Win: If the player has two in a row, they can place a third to get three in a row.


//Block: If the opponent has two in a row, the player must play the third themself to block the opponent.


//Fork: Create an opportunity where the player has two threats to win (two non-blocked lines of 2).

//Blocking an opponent's fork:
//Option 1: The player should create two in a row to force the opponent into defending, as long as it doesn't result in them creating a fork. For example, if "X" has a corner, "O" has the center, and "X" has the opposite corner as well, "O" must not play a corner in order to win. (Playing a corner in this scenario creates a fork for "X" to win.)

//Option 2: If there is a configuration where the opponent can fork, the player should block that fork.

//Center: A player marks the center. (If it is the first move of the game, playing on a corner gives "O" more opportunities to make a mistake and may therefore be the better choice; however, it makes no difference between perfect players.)

//Opposite corner: If the opponent is in the corner, the player plays the opposite corner.
//Empty corner: The player plays in a corner square.
//Empty side: The player plays in a middle square on any of the 4 sides.

@end


