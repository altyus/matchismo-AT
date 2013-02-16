//
//  PlayingCard.m
//  StanfordCardGame
//
//  Created by Al Tyus on 2/1/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int suitMatches = 0;
    int rankMatches = 0;
    
    //iterate through cards in Array and check for rank and suit matches
    for (Card *otherCard in otherCards)
    {
        //Check if Card is Playing Card
        if ([otherCard isKindOfClass:[PlayingCard class]])
             {
                 PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
                 // match suits and ranks
                 if ([otherPlayingCard.suit isEqualToString:self.suit])
                      {
                          suitMatches++;
                      }
                 else if (otherPlayingCard.rank == self.rank)
                      {
                          rankMatches++;
                          NSLog(@"Rank Matches = %i", rankMatches);
                      }
             }
        
    }
    #define RANK_MULTIPLIER  4
    #define SUIT_MULTIPLIER  2
    // do all cards match?
    if (suitMatches == [otherCards count]) score += suitMatches;
    NSLog(@"rankMatches = %i otherCards count = %i", rankMatches, [otherCards count]);
    if (rankMatches == [otherCards count]) score += RANK_MULTIPLIER;
    
   
    
    return score;
}

- (NSString *)contents
{
    
    return [[PlayingCard rankStrings] [self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
    
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

+ (NSArray *)validSuits
{
    return @[@"♠",@"♣",@"♥",@"♦"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}



@end
