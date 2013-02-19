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
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;


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

/*
- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}
*/

- (void)updateUI
{
    
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setBackgroundImage: [UIImage imageNamed:@"playingCardFront.png"] forState:UIControlStateNormal];
        
        NSDictionary *contentsDictionary = [[NSDictionary alloc] initWithDictionary:card.contentsDictionary];
        NSString *plainString = [card.contentsDictionary valueForKey:@"shape"];
        
        int paddingLength = [[card.contentsDictionary valueForKey:@"numberOfSymbols"] integerValue] ;
        
        plainString = [plainString stringByPaddingToLength:paddingLength withString:plainString startingAtIndex:0];
                
        NSMutableAttributedString *cardTitleAttributedString = [[NSMutableAttributedString alloc]initWithString:plainString];
        int len = [[cardTitleAttributedString string] length];
        NSRange range = NSMakeRange(0, len);
        
        float alpha = 0;
        NSNumber *strokeWidth = [[NSNumber alloc]initWithFloat:-4.5];
        NSString *shadeString = [card.contentsDictionary valueForKey:@"shade"];
        
        // set shade 
        
        if ([[SetCard validShades] containsObject:shadeString] )
        {
            NSLog(@"Shade = %@", shadeString);
            
            if ([shadeString isEqualToString:@"striped"])
            {
                alpha = .3;
                
            }
            if ([shadeString isEqualToString:@"open"])
            {
                alpha = 0;
            }
            if ([shadeString isEqualToString:@"solid"])
            {
                alpha = 1;
            }
        }
        
        
        // set color
        
        if ([[SetCard validColors] containsObject:[card.contentsDictionary valueForKey:@"color"]])
        {
            
        }
        
        for (id key in contentsDictionary)
        {
            NSString *value = contentsDictionary [key];
            
            
        

            
            if ([[SetCard validColors] containsObject:value] )
            {
                NSString *colorString = [value stringByAppendingString:@"Color"];
                SEL colorSel = NSSelectorFromString(colorString);
                
                if ([UIColor respondsToSelector: colorSel])
                {
                    UIColor *backgroundColor  = [UIColor performSelector:colorSel];
                    NSLog(@"Alpha = %f", alpha);
                    UIColor *foregroundColor = [backgroundColor colorWithAlphaComponent:alpha];
                    
                    [cardTitleAttributedString addAttribute:NSForegroundColorAttributeName value:foregroundColor range: range];
                    
                    [cardTitleAttributedString addAttribute:NSStrokeColorAttributeName value:backgroundColor range: range];
                    
                    [cardTitleAttributedString addAttribute:NSStrokeWidthAttributeName value:strokeWidth range:range];
                }
            }
            
                        
            
        }
        
        
        //NSLog(@"cardTitleAttrString = %@",cardTitleAttributedString);
        [cardButton setAttributedTitle: cardTitleAttributedString  forState:UIControlStateNormal];
        //[cardButton setAttributedTitle: cardTitleAttributedString  forState:UIControlStateSelected];
        
    }
    
}


//- (void)updateUI
//{
//    //int i=1;
//    //NSLog(@"%i",[self.cardButtons count]);
//    
//    for (UIButton *cardButton in self.cardButtons)
//    {
//        
//        //NSLog(@"%i",i);
//        //i++;
//        
//        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
//        
//        NSDictionary *contentsDictionary = [[NSDictionary alloc] initWithDictionary:card.contentsDictionary];
//        NSString *plainString = [card.contentsDictionary valueForKey:@"shape"];
//        NSMutableAttributedString *cardTitleAttributedString = [[NSMutableAttributedString alloc]initWithString:plainString];
//        int len = [[cardTitleAttributedString string] length];
//        NSRange range = NSMakeRange(0, len);
//        
//        for (id key in contentsDictionary)
//        {
//            NSString *value = contentsDictionary [key];
//            
//            if ([key isEqualToString:@"numberOfSymbols"])
//            {
//                NSLog(@"numberOfSymbols = %@",contentsDictionary [key]);
//                //int numberOfSymbols = (int)contentsDictionary [key];
//                // NSAttributedString *cardTitleCopyAttributedString = [cardTitleAttributedString copy];
//                
//                //for (int x=0; x<numberOfSymbols; x++) {
//                //[cardTitleAttributedString appendAttributedString:cardTitleCopyAttributedString];
//                //}
//                
//            }
//           
//            
//            if ([[SetCard validColors] containsObject:value] )
//            {
//                NSString *colorString = [value stringByAppendingString:@"Color"];
//                SEL colorSel = NSSelectorFromString(colorString);
//                
//                if ([UIColor respondsToSelector: colorSel])
//                {
//                    UIColor *valueColor  = [UIColor performSelector:colorSel];
//                    [cardTitleAttributedString addAttribute:NSForegroundColorAttributeName value:valueColor range: range];
//                }
//            }
//            
//          
//        }
//        
//        
//        //NSLog(@"cardTitleAttrString = %@",cardTitleAttributedString);
//        [cardButton setAttributedTitle: cardTitleAttributedString  forState:UIControlStateNormal];
//        //[cardButton setAttributedTitle: cardTitleAttributedString  forState:UIControlStateSelected];
//       
//    }
//    
//}


/*
- (void)resetUI
{
    
    super.clickCounterLabel.text = @"Clicks: 0";
    super.scoreLabel.text = @"Score: 0";
    super.resultsOfLastFlip.text = @"Click Card to Start Game";
    self.gameTypeSelectedSegementedControl.enabled = YES;
}
*/
@end
