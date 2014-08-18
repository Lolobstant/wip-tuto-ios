//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Lolobstant on 31/03/14.
//  Copyright (c) 2014 friendlyCorp. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
    @property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
    @property (nonatomic, strong) CardMatchingGame *game;
@end

@implementation CardGameViewController


    - (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    -(CardMatchingGame *)game {
        if(!_game)
            _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        return _game;
    }

    - (Deck *)createDeck {
        return [[PlayingCardDeck alloc] init];
    }

    -(NSString *)titleForCard:(Card *)card {
        return card.isChosen ? card.contents : @"";
    }

    -(UIImage *)backgroundImageForCard:(Card *)card {
        NSLog(@"%d, %@", card.isChosen, card.isChosen?@"cardFront":@"cardBack");
        return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
    }

    - (void)updateUI{
        for (UIButton *cardButton in self.cardButtons) {
            int cardIndex = [self.cardButtons indexOfObject:cardButton];
            Card *card = [self.game cardAtIndex:cardIndex];
            [cardButton setTitle:[self titleForCard:card]
                        forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                        forState:UIControlStateNormal];
            cardButton.enabled = !card.isMatched;
            self.scoreLabel.text = [NSString stringWithFormat:@"Score:%d", self.game.score];
        }
    }

    - (IBAction)touchCardButton:(UIButton *)sender {
        int cardIndex = [self.cardButtons indexOfObject:sender];
        [self.game chooseCardAtIndex:cardIndex];
        [self updateUI];
    }

@end
