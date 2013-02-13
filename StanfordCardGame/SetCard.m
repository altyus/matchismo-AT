//
//  SetCard.m
//  StanfordCardGame
//
//  Created by Al Tyus on 2/10/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

//@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1)
    {
        SetCard *otherSetCard = [otherCards lastObject];
        if ([otherSetCard.shape isEqualToString:self.shape])
        {
            score = 1;
        }
        else if (otherSetCard.shape == self.shape)
        {
            score = 4;
        }
    }
    
    
    return score;
}

- (NSString *)contents
{
    
    //return [[self.cardColor] [self.rank] stringByAppendingString:self.suit];
    
    return [[self.cardColor stringByAppendingString:self.shape] stringByAppendingString:self.filled];
}


- (NSString *)color
{
    return _cardColor ? _cardColor : @"?";
}

- (void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape])
    {
        _shape = shape;
    }
}

- (void)setCardColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color])
    {
        _cardColor = color;
    }
}

+ (NSArray *)validColors
{
    return @[@"green",@"red",@"blue"];
}

+ (NSArray *)validShapes
{
    return @[@"triangle",@"square",@"circle"];
}

+ (NSArray *)validFills
{
    return @[@"filled",@"unfilled"];
}



@end
