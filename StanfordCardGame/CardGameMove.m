//
//  CardGameMove.m
//  StanfordCardGame
//
//  Created by Al Tyus on 3/13/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "CardGameMove.h"
#import "Card.h"

@implementation CardGameMove

-(id)initWithMoveKind:(MoveKindType)moveKind
 CardsThatWereFlipped:(NSArray *)cardsThatWereFlipped
scoreDeltaForThisMove:(int)scoreDelta
{
    self = [super init];
    
    if (self)
    {
        _scoreDeltaForThisMove = scoreDelta;
        _cardsThatWereFlipped = cardsThatWereFlipped;
        _moveKind = moveKind;
    }
    return self;    
}

- (NSString *)descriptionOfMove
{
    NSString *description;
   
    if (self.moveKind == MoveKindFlipUp)
    {
        description = [NSString stringWithFormat:@"Flipped up %@", [[self.cardsThatWereFlipped lastObject] contents]];
        
    }
    else if (self.moveKind == MoveKindMatchForPoints)
    {
        description = @"Matched ";
        
        //for (Card *card in self.cardsThatWereFlipped)
        for (int x=0; x < [self.cardsThatWereFlipped count] - 1; x++)
        {
            description = [description stringByAppendingString:[NSString stringWithFormat:@"%@ & ", [self.cardsThatWereFlipped [x] contents]]];
        }
        
        description = [description stringByAppendingString:[NSString stringWithFormat:@"%@ for %i points", [[self.cardsThatWereFlipped lastObject] contents], self.scoreDeltaForThisMove]] ;
        
    }
    
    else if (self.moveKind == MoveKindMismatchForPenalty)
    {
        description = [[NSString alloc]init];
        
        for (int x = 0; x< [self.cardsThatWereFlipped count] -1; x++)
        {
            description = [description stringByAppendingString:[NSString stringWithFormat:@"%@ & ", [self.cardsThatWereFlipped [x]contents]]];
        }
        description = [description stringByAppendingString:[NSString stringWithFormat:@"%@ don't match, %i point penalty", [[self.cardsThatWereFlipped lastObject]contents], self.scoreDeltaForThisMove]];
        
    }
    
    return description;
}

@end
