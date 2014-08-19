//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Lolobstant on 18/08/14.
//  Copyright (c) 2014 friendlyCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

    @property (nonatomic, readonly)NSInteger score;
    @property(nonatomic, readonly)NSString *lastAction;

    /** designated initializer **/
- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck nMatching:(NSUInteger)n;
	- (void)chooseCardAtIndex:(NSUInteger)index;
	- (Card *)cardAtIndex:(NSUInteger)index;

@end
