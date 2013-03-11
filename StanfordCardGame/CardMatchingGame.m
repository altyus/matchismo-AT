//
//  CardMatchingGame.m
//  StanfordCardGame
//
//  Created by Al Tyus on 2/1/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) NSMutableString *matchResult;
@property (strong, nonatomic) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

// designated initializer 
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

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.matchResult = [[NSMutableString alloc] init];
    //NSLog(@"You clicked a card!");
    
    //only act if card is playable
    if (card && !card.isUnplayable)
    {
        NSLog(@"card and card is playable");
        //only act if card is face down 
        if (!card.isFaceUp)
        {
            NSLog(@"not card is faceup");
            //build an array of cards to match with
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards)
            {
                //only act if otherCard is FaceUp and playable
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    [otherCards addObject:otherCard];
                }
            }
            
            //Do we need to match?
            // Matchismo Match
            if ((self.twoMatchGame && [otherCards count] == 1) || (!self.twoMatchGame && [otherCards count] == 2))
                {
                    [self matchHelper:card :otherCards];
                }
            else
            {
                //NSLog(@"reset matchresult");
                [self.matchResult appendFormat:@"Flipped up %@", [card contents]];
            }
            
    self.score -= FLIP_COST;
        
        }
        card.faceUp = !card.faceUp;
    }
}

- (void)matchHelper: (Card *)card :(NSMutableArray *)otherCards
{
    
    //calculate the match score
    int matchScore = [card match:otherCards];
    //Did we match?
    NSLog(@"Matchscore = %i", matchScore);
    
    if (matchScore)
    {
        //add matchScore to score
        self.score += matchScore * MATCH_BONUS;
        //make card unplayable
        card.unplayable = YES;
        
        //add first card to Feedback string
        
        [self.matchResult appendFormat:@"Matched %@ ", [card contents]];
        
        //iterate through other cards and set to unplayable
        for (Card *otherCard in otherCards)
        {
            otherCard.unplayable = YES;
            // Format Text for not last object
            if (![otherCard isEqual:[otherCards lastObject]])
            {
                [self.matchResult appendFormat:@"& %@ ", [otherCard contents]];
            }
            else
            {
                [self.matchResult appendFormat:@"& %@ for %d points!", [otherCard contents],matchScore * MATCH_BONUS];
            }
        }
    }
    //no match and penalize
    else
    {
        self.score -= MISMATCH_PENALTY * [otherCards count];

        //First Feedback line
        [self.matchResult appendFormat:@"%@ & ", [card contents] ];
        
        //iterate over cards that didn't match
        for (Card *otherCard in otherCards)
        {
            otherCard.faceUp = NO;
            //Add feedback to Cards that are not last card in Array
            if (![otherCard isEqual:[otherCards lastObject]])
            {
                [self.matchResult appendFormat:@"%@ & ", [otherCard contents]];
            }
            else
            {
                [self.matchResult appendFormat:@"%@ don't match, %d point penalty!", [otherCard contents], MISMATCH_PENALTY];
            }
        }
    }
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end


