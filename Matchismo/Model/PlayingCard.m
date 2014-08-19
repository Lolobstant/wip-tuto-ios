//
//  PlayingCard.m
//  Matchismo
//
//  Created by Lolobstant on 18/08/14.
//  Copyright (c) 2014 friendlyCorp. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

    -(NSString *)contents {
        NSArray *rankArray = [PlayingCard rankString];
        return [rankArray[self.rank] stringByAppendingString:self.suit];
    }

@synthesize suit = _suit;

    +(NSArray *)validSuits {
        return @[@"♡", @"♣︎", @"♠︎", @"♢"];
    }

    -(void)setSuit:(NSString *)suit {
        if ([[PlayingCard validSuits] containsObject:suit])
            _suit = suit;
    }

    -(NSString *)suit {
        return _suit ? _suit : @"?";
    }

    +(NSArray *)rankString {
        return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    }

    + (NSUInteger)maxRank {
        return [[self rankString] count] - 1;
    }

    -(void)setRank:(NSUInteger)rank {
        if (rank <= [PlayingCard maxRank])
            _rank = rank;
    }

    -(int)match:(NSArray *)otherCards {
        int score = 0;
        int flag = 0;
        for (int i = 0; i < [otherCards count]; i++) {
            PlayingCard *otherCard = otherCards[i];
            if (otherCard.rank == self.rank) {
                score += 4 * (i + 1);
                flag++;
            }
            else if (otherCard.suit == self.suit) {
                score += 1 * (i + 1);
                flag++;
            }
        }
        return score;
    }

@end
