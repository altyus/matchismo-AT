//
//  SetDeck.m
//  StanfordCardGame
//
//  Created by Al Tyus on 2/10/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

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
                for (NSString *filled in [SetCard validFills])
                {
                SetCard *card = [[SetCard alloc]init];
                card.cardColor = color;
                card.shape = shape;
                card.filled = filled;
                    
                [self addCard:card atTop:YES];
            
                }
                
            }
        }
        
    }
    
    return self;
}

@end
