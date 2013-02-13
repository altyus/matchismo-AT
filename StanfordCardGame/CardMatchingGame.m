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


@property (strong, nonatomic)Card *threeCardOne;
@property (strong, nonatomic)Card *threeCardTwo;
@property (strong, nonatomic)Card *threeCardThree;

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

-(void)setThreeCardValues
{
    for (Card *nextCard in self.cards)
    {
        if (nextCard.isFaceUp && !nextCard.isUnplayable) {
            
            if (!self.threeCardOne)
            {
                self.threeCardOne = nextCard;
                break;
            }
            else if (!self.threeCardTwo && ![nextCard isEqual:self.threeCardOne])
            {
                self.threeCardTwo = nextCard;
                break;
            }
            else if (!self.threeCardThree && ![nextCard isEqual:self.threeCardOne] && ![nextCard isEqual:self.threeCardTwo])
            {
                self.threeCardThree = nextCard;
            }
        }
        
    }
}

-(void)resetThreeCardValue
{
    self.threeCardOne = nil;
    self.threeCardTwo = nil;
    self.threeCardThree = nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

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

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


@end


