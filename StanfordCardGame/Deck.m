//
//  Deck.m
//  StanfordCardGame
//
//  Created by Al Tyus on 2/1/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation Deck

- (NSMutableArray *)cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (card)
    {
        if (atTop)
        {
            [self.cards insertObject:card atIndex:0];
        }
        else
        {
            [self.cards addObject:card];
        }
    }
    
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    //NSLog(@"Value of self.cards.count %d",self.cards.count);
    
    if (self.cards.count)
    {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }    
    
    return randomCard;
}

@end
