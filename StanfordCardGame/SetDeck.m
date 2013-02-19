//
//  SetDeck.m
//  StanfordCardGame
//
//  Created by Al Tyus on 2/10/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"
/*
+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShades;
*/
@implementation SetDeck
- (id)init
{
    self = [super init];
    
    if (self)
    {
        for (NSString *color in [SetCard validColors])
        {
            for (NSString *shape in [SetCard validShapes])
            {
                for (NSString *shade in [SetCard validShades])
                {
                    for (NSInteger counter = 1; counter <= [SetCard maxNumberOfSymbols];  counter++)
                    {
                        SetCard *card = [[SetCard alloc]init];
                        card.color = color;
                        card.shape = shape;
                        card.shade = shade;
                        card.numberOfSymbols = [NSNumber numberWithInt:counter];
                        [self addCard:card atTop:YES];
                    }
                    
                }
                
            }
        }
        
    }
    
    return self;
}

@end
