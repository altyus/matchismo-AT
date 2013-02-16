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
@property (readwrite, nonatomic) NSString *matchResult;

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
/*
-(void)flipCardAtIndex:(NSUInteger)index
{
    
  //  NSLog(@"Card at index 0: %@",[[self.cards objectAtIndex:10] contents]);
    Card *card = [self cardAtIndex:index];
    
    if (card && !card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            
        
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    NSLog(@"otherCard.isFaceUP && !otherCard.isUnplayable");
                    
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore)
                    {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.matchResult = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", [card contents], [otherCard contents], MATCH_BONUS];
                        NSLog(@"Card Contents %@", [card contents]);
                        
                    }
                    else
                    {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.matchResult = [NSString stringWithFormat:@"%@ & %@ don't match! %d point penalty!", [card contents], [otherCard contents], MISMATCH_PENALTY];
                    
                    }
                    break;
                
                }
                else if (!otherCard.isFaceUp)
                {
                    self.matchResult = [NSString stringWithFormat:@"Flipped up %@", [card contents]];
                }
            }
        self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
        
    }
    
}
*/

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    //only act if card is playable 
    if (card && !card.isUnplayable)
    {
        //only act if card is face down 
        if (!card.isFaceUp)
        {
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
            if ((self.twoMatchGame && [otherCards count] == 1) || (!self.twoMatchGame && [otherCards count] == 2))
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
                        
                        //iterate through other cards and set to unplayable
                        for (Card *otherCard in otherCards)
                        {
                            otherCard.unplayable = YES;
                        }
                        
                    }
                   //no match and penalize  
                    else
                    {
                        self.score -= MISMATCH_PENALTY * [otherCards count];
                        
                        
                        
                        //iterate over cards that didn't match
                        for (Card *otherCard in otherCards)
                        {
                            otherCard.faceUp = NO;
                            self.matchResult = [NSString stringWithFormat:@"%@ & %@ don't match! %d point penalty!", [card contents], [otherCard contents], MISMATCH_PENALTY];
                        }
                        
                        
                    }
            
                }
    self.score -= FLIP_COST;
        
        }
        card.faceUp = !card.faceUp;
        
    }
    
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


@end


