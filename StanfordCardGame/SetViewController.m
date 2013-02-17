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
        
        NSLog(@"card contents = %@,", card.contents);
        
        //set the back image of the card
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        //[cardButton setBackgroundImage: [UIImage imageNamed:@"cardBack.png"] forState:UIControlStateNormal];
        //[cardButton setBackgroundImage: [UIImage imageNamed:@"cardBack.png"] forState:UIControlStateSelected];
        //[cardButton setBackgroundImage: [UIImage imageNamed:@"cardBack.png"] forState:UIControlStateSelected | UIControlStateDisabled];
        
        
        // set the title of the card
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        
        //cardButton.selected = card.isFaceUp;
        
        
        cardButton.selected = YES;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? .2 : 1.0);
    }
    //self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    //self.resultsOfLastFlip.text = self.game.matchResult;
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
