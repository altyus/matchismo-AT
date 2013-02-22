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
        
        //Create String Object to start building Attributed String
        NSString *plainString = [card.contentsDictionary valueForKey:@"shape"];
        int paddingLength = [[card.contentsDictionary valueForKey:@"numberOfSymbols"] integerValue] ;
        plainString = [plainString stringByPaddingToLength:paddingLength withString:plainString startingAtIndex:0];
                
        //set Attributed Title using helperMethod cardTitleAttributedStringHelper
        [cardButton setAttributedTitle: [self cardTitleAttributedStringHelper:plainString :card]   forState:UIControlStateNormal];
        
        // Set Card Buttons enabled and alpha values 
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0 : 1.0);
    
    }// end for loop
}

- (NSAttributedString *)cardTitleAttributedStringHelper: (NSString *)plainString : (Card *)card
{
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

@end
