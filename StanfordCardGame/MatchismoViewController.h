//
//  ViewController.h
//  StanfordCardGame
//
//  Created by Al Tyus on 1/31/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCard.h"

@interface MatchismoViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *clickCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsOfLastFlip;

@end
