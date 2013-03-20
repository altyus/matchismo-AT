//
//  SetViewController.m
//  StanfordCardGame
//
//  Created by Al Tyus on 2/10/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "SetViewController.h"
#import "SetMatchingGame.h"
#import "SetDeck.h"
#import "SetCard.h"
#import "CardGameMove.h"
//#import "MatchismoViewController.h"

@interface SetViewController ()
@property (strong, nonatomic) SetMatchingGame *game;
@end

@implementation SetViewController

//Lazy Instantiation

- (SetMatchingGame *)game
{
    if (!_game)
    {
        _game = [[SetMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[[SetDeck alloc]init]];
    }
    return _game;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)updateUI
{
    
    //Iterate through buttons in button collection Array
    for (UIButton *cardButton in self.cardButtons)
    {
        //Create Card Object and set Card's background image
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setBackgroundImage: [UIImage imageNamed:@"playingCardFront.png"] forState:UIControlStateNormal];
        
        
      
                
        //set Attributed Title using helperMethod cardTitleAttributedStringHelper
        [cardButton setAttributedTitle: [self cardTitleAttributedStringHelper:card]   forState:UIControlStateNormal];
        
        // Set Card Buttons enabled and alpha values 
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.0 : 1.0);
        
        cardButton.alpha = (cardButton.isSelected ? 0.1: 1.0);
    
    }// end for loop
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    //self.resultsOfLastFlip.text = self.game.matchResult;
    if ([self.game.moveHistory count])
    {
    [self updateResultsOfLastFlipLabel:[self.game.moveHistory lastObject]];
    }
    
    
}

- (NSAttributedString *)cardTitleAttributedStringHelper: (Card *)card
{
    
    //Create String Object to start building Attributed String
    NSString *plainString = [card.contentsDictionary valueForKey:@"shape"];
    int paddingLength = [[card.contentsDictionary valueForKey:@"numberOfSymbols"] integerValue];
    plainString = [plainString stringByPaddingToLength:paddingLength withString:plainString startingAtIndex:0];
    
    //Build Attributed String from plain string
    NSMutableAttributedString *cardTitleAttributedString = [[NSMutableAttributedString alloc]initWithString:plainString];
    NSRange range = NSMakeRange(0, [[cardTitleAttributedString string] length]);
    
    //Define Values for attributes and initialize alpha value
    float alpha = 0;
#define STROKEWIDTH -4.5
#define TRANSLUCENT_ALPHA .3
#define UNFILLED_ALPHA 0
#define FILLED_ALPHA 1
    
    NSNumber *strokeWidth = [[NSNumber alloc]initWithFloat:STROKEWIDTH];
    NSString *shadeString = [card.contentsDictionary valueForKey:@"shade"];
    NSString *colorString = [card.contentsDictionary valueForKey:@"color"];
    
    // set shade value
    
    if ([[SetCard validShades] containsObject:shadeString] )
    {
        if ([shadeString isEqualToString:@"translucent"])
        {
            alpha = TRANSLUCENT_ALPHA;
            
        }
        if ([shadeString isEqualToString:@"unfilled"])
        {
            alpha = UNFILLED_ALPHA;
        }
        if ([shadeString isEqualToString:@"filled"])
        {
            alpha = FILLED_ALPHA;
        }
    }
    
    
    // set color
    
    if ([[SetCard validColors] containsObject:[card.contentsDictionary valueForKey:@"color"]])
    {
        NSString *colorWorkString = [colorString stringByAppendingString:@"Color"];
        SEL colorSel = NSSelectorFromString(colorWorkString);
        
        if ([UIColor respondsToSelector: colorSel])
        {
            UIColor *backgroundColor  = [UIColor performSelector:colorSel];
            UIColor *foregroundColor = [backgroundColor colorWithAlphaComponent:alpha];
            
            //add attributes to attributed string
            [cardTitleAttributedString addAttribute:NSForegroundColorAttributeName value:foregroundColor range: range];
            [cardTitleAttributedString addAttribute:NSStrokeColorAttributeName value:backgroundColor range: range];
            [cardTitleAttributedString addAttribute:NSStrokeWidthAttributeName value:strokeWidth range:range];
        }
    }// end if
    
    return cardTitleAttributedString;
}

+(NSAttributedString *)attributedResultSeparator
{
    return [[NSAttributedString alloc] initWithString:@" & "];
}

- (void)updateResultsOfLastFlipLabel: (CardGameMove *)move
{
    //self.resultsOfLastFlip.text = [move descriptionOfMove];
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]init];
    
    if (move.moveKind == MoveKindFlipUp)
    {
        [result appendAttributedString:[[NSAttributedString alloc]initWithString:@"Flipped Up "]];
        [result appendAttributedString: [self cardTitleAttributedStringHelper:[move.cardsThatWereFlipped lastObject]]];
    }
    else if (move.moveKind == MoveKindMatchForPoints)
    {
        [result appendAttributedString:[[NSAttributedString alloc]initWithString:@"Matched "]];
        
        //for (Card *card in self.cardsThatWereFlipped)
        for (int x=0; x < [move.cardsThatWereFlipped count] - 1; x++)
        {
            Card *card = move.cardsThatWereFlipped[x];
            [result appendAttributedString:[self cardTitleAttributedStringHelper:card]];
            [result appendAttributedString:[SetViewController attributedResultSeparator]];
            //result = [description stringByAppendingString:[NSString stringWithFormat:@"%@ & ", [self.cardsThatWereFlipped [x] contents]]];
        }
        
        [result appendAttributedString:[self cardTitleAttributedStringHelper:[move.cardsThatWereFlipped lastObject]]];
        
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %i points",move.scoreDeltaForThisMove]]];

        //result = [description stringByAppendingString:[NSString stringWithFormat:@"%@ for %i points", [[self.cardsThatWereFlipped lastObject] contents], self.scoreDeltaForThisMove]] ;
        
    }
    else if (move.moveKind == MoveKindMismatchForPenalty)
    {
        for (int x=0; x < [move.cardsThatWereFlipped count] - 1; x++)
        {
            Card *card = move.cardsThatWereFlipped[x];
            [result appendAttributedString:[self cardTitleAttributedStringHelper:card]];
            [result appendAttributedString:[SetViewController attributedResultSeparator]];
            //result = [description stringByAppendingString:[NSString stringWithFormat:@"%@ & ", [self.cardsThatWereFlipped [x] contents]]];
        }
        [result appendAttributedString:[self cardTitleAttributedStringHelper:[move.cardsThatWereFlipped lastObject]]];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match, %i point penalty", move.scoreDeltaForThisMove]]];
        
        
    }
    self.resultsOfLastFlip.attributedText = result;
    
}

@end


//[NSString stringWithFormat:(@"%@ %@ %@ %@", shape,)