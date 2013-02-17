//
//  SetCard.h
//  StanfordCardGame
//
//  Created by Al Tyus on 2/10/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong)NSString *filled;
@property (nonatomic, strong)NSString *shape;
@property (nonatomic, strong)UIColor *cardColor;
@property (nonatomic)NSUInteger *numberOfSymbols;

+ (int)maxNumberOfSymbols;
+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validFills;

@end
