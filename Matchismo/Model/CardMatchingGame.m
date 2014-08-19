//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Lolobstant on 18/08/14.
//  Copyright (c) 2014 friendlyCorp. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
    @property (nonatomic, readwrite)NSInteger score;
    @property (nonatomic, strong)NSMutableArray	*cards;
    @property (nonatomic)NSUInteger n;
    -(NSUInteger)matchCards:(NSMutableArray *)cards;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

    -(NSMutableArray *)cards {
        if(!_cards)
            _cards = [[NSMutableArray alloc] init];
        return _cards;
    }

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck nMatching:(NSUInteger)n {
        self = [super init];

        if (self) {
            self.n = n;
            for (int i = 0; i < count; i++) {
                Card *card = [deck drawRandomCard];
                if (card)
                    [self.cards addObject:card];
                else {
                    self = nil;
                    break;
                }
            }
        }
        return self;
    }

    -(void)chooseCardAtIndex:(NSUInteger)index {
        Card *card = [self cardAtIndex:index];
        NSMutableArray *cardList = [[NSMutableArray alloc] init];
        NSLog(@"[here !!!] %d", self.n);
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
            }
            else {
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [cardList addObject:otherCard];
                        if ([cardList count] + 1 == self.n) {
                            [cardList addObject:card];
                            int matchScore = [self matchCards:cardList];
                            if (matchScore) {
                                self.score += matchScore * MATCH_BONUS;
                                card.matched = YES;
                                for (Card *other in cardList)
                                    other.matched = YES;
                            }
                            else {
                                self.score -= MISMATCH_PENALTY - (self.n - 2);
                                for (Card *other in cardList)
                                    other.chosen = NO;
                            }
                            break;
                        }
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    }

    -(NSUInteger)matchCards:(NSMutableArray *)cards {
        int flag = 0;
        int score = 0;
        NSMutableArray *cardsSave = [[NSMutableArray alloc] initWithArray:cards];
        while([cardsSave count]) {
            Card *currentCard = cardsSave[0];
            [cardsSave removeObjectAtIndex:0];
            NSLog(@"cardCount = %d", [cardsSave count]);
            if ([cardsSave count]) {
                int matchScore = [currentCard match:cardsSave];
                NSLog(@"matchScoreLocal = %d", matchScore);
                if (matchScore) {
                    score += matchScore;
                    flag++;
                }
            }
        }
        NSLog(@"flag = %d, cardsCount = %d", flag, [cards count]);
        if (flag < [cards count] - 1)
            score = 0;
        return score;
    }


    -(Card*)cardAtIndex:(NSUInteger)index {
        return (index < [self.cards count]) ? self.cards[index] : nil;
    }

@end
