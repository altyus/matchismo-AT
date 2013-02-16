//
//  ViewController.m
//  StanfordCardGame
//
//  Created by Al Tyus on 1/31/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "MatchismoViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface MatchismoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *clickCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsOfLastFlip;
@property (nonatomic) int clickCounter;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeSelectedSegementedControl;


@end

@implementation MatchismoViewController

-(CardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc]init]];
        //set initial game mode to twoMatchGame
        self.game.twoMatchGame = YES;
    }
    return _game;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self resetUI];
    //self.game.twoMatchGame = YES;
    
    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [self.gameTypeSelectedSegementedControl setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    NSLog(@"self.game.twoMatchGame = %i", self.game.twoMatchGame);
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        //set the back image of the card
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage: [UIImage imageNamed:@"playingCardBack.png"] forState:UIControlStateNormal];
        [cardButton setBackgroundImage: [UIImage imageNamed:@"playingCardFront.png"] forState:UIControlStateSelected];
        [cardButton setBackgroundImage: [UIImage imageNamed:@"playingCardFront.png"] forState:UIControlStateSelected | UIControlStateDisabled];
        
        
        // set the title of the card
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];

        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? .2 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultsOfLastFlip.text = self.game.matchResult;
}

- (IBAction)flipCard:(UIButton *)sender
{
    if (self.gameTypeSelectedSegementedControl.enabled)
    {
        self.gameTypeSelectedSegementedControl.enabled = NO;
        
    }
    self.clickCounter++;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
}

- (IBAction)deal:(UIButton *)sender
{
    self.game = nil;
    self.clickCounter = 0;
    [self resetUI];
    [self updateUI];
}

- (IBAction)gameTypeSelected:(UISegmentedControl *)sender
{
    if (self.game)
    {
        if (sender.selectedSegmentIndex == 0)
        {
            self.game.twoMatchGame = YES;
        }
        else if (sender.selectedSegmentIndex == 1)
        {
            self.game.twoMatchGame = NO;
        }
        NSLog(@"self.game.twoMatchGame = %i", self.game.twoMatchGame);
    }
}

- (void)resetUI
{
    self.clickCounterLabel.text = @"Clicks: 0";
    self.scoreLabel.text = @"Score: 0";
    self.resultsOfLastFlip.text = @"Click Card to Start Game";
    self.gameTypeSelectedSegementedControl.enabled = YES;
    
    if (self.gameTypeSelectedSegementedControl.selectedSegmentIndex == 0)
    {
        self.game.twoMatchGame = YES;
    }
    else if (self.gameTypeSelectedSegementedControl.selectedSegmentIndex == 1)
    {
        self.game.twoMatchGame = NO;
    }

}

- (void)setClickCounter:(int)clickCounter
{
    _clickCounter = clickCounter;
    self.clickCounterLabel.text = [NSString stringWithFormat:@"Clicks: %d", self.clickCounter];
}


@end
