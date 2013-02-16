//
//  CardMatchingGame.h
//  StanfordCardGame
//
//  Created by Al Tyus on 2/1/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
#import "PlayingCard.h"

@interface CardMatchingGame : NSObject

-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;

@property (readonly, nonatomic) NSMutableString *matchResult;

@property (nonatomic, getter = isTwoMatchGame) BOOL twoMatchGame;

@end
