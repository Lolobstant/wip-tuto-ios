//
//  PlayingCard.h
//  Matchismo
//
//  Created by Lolobstant on 18/08/14.
//  Copyright (c) 2014 friendlyCorp. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
    @property (strong, nonatomic) NSString* suit;
    @property (nonatomic) NSUInteger rank;

    + (NSArray *)validSuits;
    + (NSUInteger)maxRank;
@end
