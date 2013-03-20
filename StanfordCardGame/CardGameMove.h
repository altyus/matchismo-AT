//
//  CardGameMove.h
//  StanfordCardGame
//
//  Created by Al Tyus on 3/13/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MoveKindType)
{
    MoveKindFlipUp,
    MoveKindMatchForPoints,
    MoveKindMismatchForPenalty
    
};

@interface CardGameMove : NSObject

-(id)initWithMoveKind:(MoveKindType)moveKind
CardsThatWereFlipped:(NSArray *)cardsThatWereFlipped
scoreDeltaForThisMove:(int)scoreDelta;

-(NSString *)descriptionOfMove;

@property (nonatomic) NSArray *cardsThatWereFlipped; // array holds card pointers
@property (nonatomic) int scoreDeltaForThisMove;

@property (nonatomic) MoveKindType moveKind;

@end
