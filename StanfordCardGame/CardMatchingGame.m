//
//  CardMatchingGame.m
//  StanfordCardGame
//
//  Created by Al Tyus on 2/1/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "CardMatchingGame.h"
#import "CardGameMove.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (strong, nonatomic) NSDictionary *feedbackDictionary; //Description of FeedBack types 

@property (strong, nonatomic) CardGameMove *move;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(NSMutableArray *)moveHistory
{
    if (!_moveHistory)
    {
        _moveHistory =[[NSMutableArray alloc] init];
        
    }
    return _moveHistory;
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
            
            //build an array of all cards flipped up 
            NSMutableArray *allCardsInPlay = [[NSMutableArray alloc]init];
            
            for (Card *otherCard in self.cards)
            {
                //only act if otherCard is FaceUp and playable
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    [otherCards addObject:otherCard];
                }
            }
            
            allCardsInPlay = [otherCards mutableCopy];
            [allCardsInPlay addObject:card];
            
            
            
            //NSLog(@"Number of cards face up %i", [otherCards count]);
            NSLog(@"Number of cards in allCardsInPlay %i", [allCardsInPlay count]);
            
            
            //Do we need to match?
            // Matchismo Match
            if ((self.twoMatchGame && [otherCards count] == 1) || (!self.twoMatchGame && [otherCards count] == 2))
                {
                    [self matchHelper:card :otherCards :self.move :allCardsInPlay];
                
                }
            else
            {
                self.move = [[CardGameMove alloc]initWithMoveKind:MoveKindFlipUp
                                        CardsThatWereFlipped:allCardsInPlay
                                       scoreDeltaForThisMove:FLIP_COST * -1];
                [self.moveHistory addObject:self.move];
                
            }
            
    self.score -= FLIP_COST;
    
        
        }
        card.faceUp = !card.faceUp;
    }
    
}

- (void)matchHelper: (Card *)card :(NSMutableArray *)otherCards :(CardGameMove *)move :(NSArray *)allCardsInPlay
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
        
        move = [[CardGameMove alloc]initWithMoveKind:MoveKindMatchForPoints
                                CardsThatWereFlipped:allCardsInPlay
                               scoreDeltaForThisMove:matchScore * MATCH_BONUS];
        [self.moveHistory addObject:move];
        
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
        
        move = [[CardGameMove alloc]initWithMoveKind:MoveKindMismatchForPenalty
                                CardsThatWereFlipped:allCardsInPlay
                               scoreDeltaForThisMove:MISMATCH_PENALTY * [otherCards count]];
        [self.moveHistory addObject:move];
        
        //iterate over cards that didn't match
        for (Card *otherCard in otherCards)
        {
            otherCard.faceUp = NO;
            //Add feedback to Cards that are not last card in Array
        }
    }
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end


