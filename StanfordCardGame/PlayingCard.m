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
    
    if ([otherCards count] == 1)
    {
        PlayingCard *otherPlayingCard = [otherCards lastObject];
        if ([otherPlayingCard.suit isEqualToString:self.suit])
        {
            score = 1;
        }
        else if (otherPlayingCard.rank == self.rank)
        {
            score = 4;
        }
    }
   
    
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
