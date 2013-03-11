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
@synthesize color = _color;
@synthesize shape = _shape;
@synthesize shade = _shade;
@synthesize numberOfSymbols = _numberOfSymbols;

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

- (NSDictionary *)contentsDictionary
{
    
    //return [[self.cardColor] [self.rank] stringByAppendingString:self.suit];
    NSDictionary *cardContentsDictionary =@{ @"color" : self.color,
                                             @"shape" : self.shape,
                                             @"shade" : self.shade,
                                             @"numberOfSymbols" : self.numberOfSymbols
                                             };
    
    
    return cardContentsDictionary;
    
}


- (NSNumber *)numberOfSymbols
{
    return _numberOfSymbols.intValue <= [SetCard maxNumberOfSymbols] ? _numberOfSymbols : 0;
}


- (NSString *)color
{
    return _color ? _color : @"?";
}

- (void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape])
    {
        _shape = shape;
    }
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color])
    {
        _color = color;
    }
}

#define MAXSYMBOLS 3

+ (NSInteger)maxNumberOfSymbols
{
    return MAXSYMBOLS;
    
}

+ (NSArray *)validColors
{
    return @[@"green",@"red",@"blue"];
}

+ (NSArray *)validShapes
{
    return @[@"▲",@"■",@"●"];
}

+ (NSArray *)validShades
{
    return @[@"filled",@"unfilled",@"translucent"];
}

- (NSString *)contents
{
    
    
    NSArray *setCardContentsArray = [self.contentsDictionary allValues];
    NSString *setCardContents = [setCardContentsArray componentsJoinedByString:@" "];
    
    NSLog(@"%@",setCardContents);
    return setCardContents;
}


@end
