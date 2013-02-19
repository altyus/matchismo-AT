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
    //int i=1;
    //NSLog(@"%i",[self.cardButtons count]);
    
    for (UIButton *cardButton in self.cardButtons)
    {
        
        //NSLog(@"%i",i);
        //i++;
        
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        NSDictionary *contentsDictionary = [[NSDictionary alloc] initWithDictionary:card.contentsDictionary];
        NSString *plainString = [card.contentsDictionary valueForKey:@"shape"];
        NSMutableAttributedString *cardTitleAttributedString = [[NSMutableAttributedString alloc]initWithString:plainString];
        int len = [[cardTitleAttributedString string] length];
        NSRange range = NSMakeRange(0, len);
        
        for (id key in contentsDictionary)
        {
            NSString *value = contentsDictionary [key];
            
            if ([key isEqualToString:@"numberOfSymbols"])
            {
                NSLog(@"numberOfSymbols = %@",contentsDictionary [key]);
                //int numberOfSymbols = (int)contentsDictionary [key];
                // NSAttributedString *cardTitleCopyAttributedString = [cardTitleAttributedString copy];
                
                //for (int x=0; x<numberOfSymbols; x++) {
                //[cardTitleAttributedString appendAttributedString:cardTitleCopyAttributedString];
                //}
                
            }
           
            
            if ([[SetCard validColors] containsObject:value] )
            {
                NSString *colorString = [value stringByAppendingString:@"Color"];
                SEL colorSel = NSSelectorFromString(colorString);
                
                if ([UIColor respondsToSelector: colorSel])
                {
                    UIColor *valueColor  = [UIColor performSelector:colorSel];
                    [cardTitleAttributedString addAttribute:NSForegroundColorAttributeName value:valueColor range: range];
                }
            }
            
          
        }
        
        
        //NSLog(@"cardTitleAttrString = %@",cardTitleAttributedString);
        [cardButton setAttributedTitle: cardTitleAttributedString  forState:UIControlStateNormal];
        //[cardButton setAttributedTitle: cardTitleAttributedString  forState:UIControlStateSelected];
       
    }
    
}



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
