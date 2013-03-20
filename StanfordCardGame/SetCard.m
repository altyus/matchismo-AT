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
    
    bool allNumberOfSymbolsMatch = NO;
    bool allColorsMatch = NO;
    bool allShapesMatch = NO;
    bool allShadesMatch = NO;
   
    bool allNumberOfSymbolsDiffer = NO;
    bool allColorsDiffer = NO;
    bool allShapesDiffer = NO;
    bool allShadesDiffer = NO;
    
    SetCard *card1 = self;
    SetCard *card2 = otherCards [0];
    SetCard *card3 = otherCards [1];
    
    //Set Boolean value if all of a property are the same 
    if (card1.numberOfSymbols == card2.numberOfSymbols && card1.numberOfSymbols == card3.numberOfSymbols)
    {
        allNumberOfSymbolsMatch = YES;
    }
    if ([card1.color isEqualToString:card2.color] && [card1.color isEqualToString:card3.color])
    {
        allColorsMatch = YES;
    }
    if ([card1.shape isEqualToString:card2.shape] && [card1.shape isEqualToString:card3.shape])
    {
        allShapesMatch = YES;
    }
    if ([card1.shade isEqualToString:card2.shade] && [card1.shade isEqualToString:card3.shade])
    {
        allShadesMatch = YES;
    }
    
    //Set Boolean value if all of a property are distinct 
    if (card1.numberOfSymbols != card2.numberOfSymbols && card2.numberOfSymbols != card3.numberOfSymbols && card1.numberOfSymbols != card3.numberOfSymbols)
    {
        allNumberOfSymbolsDiffer = YES;
    }
    if (![card1.color isEqualToString:card2.color] && ![card2.color isEqualToString:card3.color] && ![card1.color isEqualToString:card3.color])
    {
        allColorsDiffer = YES;
    }
    if (![card1.shape isEqualToString:card2.shape] && ![card2.shape isEqualToString:card3.shape] && ![card1.shape isEqualToString:card3.shape])
    {
        allShapesDiffer = YES;
    }
    if (![card1.shade isEqualToString:card2.shade] && ![card2.shade isEqualToString:card3.shade] && ![card1.shade isEqualToString:card3.shade])
    {
        allShadesDiffer = YES;
    }
    


    if (!allNumberOfSymbolsMatch && !allNumberOfSymbolsDiffer)
    {
        score = 0;
    }
    else if (!allColorsMatch && !allColorsDiffer)
    {
        score = 0;
    }
    else if (!allShapesMatch && !allShapesDiffer)
    {
        score = 0;
    }
    else if (!allShadesMatch && !allShadesDiffer)
    {
        score = 0;
    }
    else
    {
        score = 1;
    }

    NSLog(@"Score = %i", score);
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
