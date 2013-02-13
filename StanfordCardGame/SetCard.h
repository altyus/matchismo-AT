//
//  SetCard.h
//  StanfordCardGame
//
//  Created by Al Tyus on 2/10/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic)NSString *filled;
@property (nonatomic)NSString *shape;
@property (nonatomic)NSString *cardColor;

+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validFills;

@end
