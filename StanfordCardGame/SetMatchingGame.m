//
//  SetMatchingGame.m
//  StanfordCardGame
//
//  Created by Al Tyus on 2/16/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "SetMatchingGame.h"
@interface SetMatchingGame()

//@property (strong, nonatomic) NSMutableArray *cards; // of Card

@end

@implementation SetMatchingGame

  // designated initializer
/*
-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
        self = [super init];
        if (self)
        {
            for (int i=0; i< count; ++i)
            {
                Card *card = [deck drawRandomCard];
                if (card)
                {
                    self.cards[i] = card;
                }
                else
                {
                    self = nil;
                    break;
                }
            }
        }
        return self;
}
*/
/*
-(void)selectCardAtIndex:(NSUInteger)index
{
    
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    //this method was last causing me issues not having index of cards and not having yet set cards!! 
    NSLog(@"self.cards[index]: %@", self.cards[index]);
    return (index < [self.cards count]) ? self.cards[index] : nil;
    //return nil;
}
*/
@end
