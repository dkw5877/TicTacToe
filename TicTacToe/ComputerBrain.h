//
//  ComputerBrain.h
//  TicTacToe
//
//  Created by user on 3/14/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComputerBrain : NSObject

- (id)initWithGameBoard:(NSMutableArray*)gameBoard;
- (id)initWithGameBoard:(NSMutableArray*)gameBoard andCurrentPlayer:(NSString*)player;
-(NSInteger)makeMove;

@end
