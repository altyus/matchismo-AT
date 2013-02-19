//
//  SetCard.h
//  StanfordCardGame
//
//  Created by Al Tyus on 2/10/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong)NSString *shade;
@property (nonatomic, strong)NSString *shape;
@property (nonatomic, strong)NSString *color;
@property (nonatomic, strong)NSNumber *numberOfSymbols;

//@property (nonatomic, strong) NSDictionary *contentsDictionary;

+ (NSInteger)maxNumberOfSymbols;
+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShades;

@end
