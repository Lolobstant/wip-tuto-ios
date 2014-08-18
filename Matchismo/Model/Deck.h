//
//  Deck.h
//  Matchismo
//
//  Created by Lolobstant on 18/08/14.
//  Copyright (c) 2014 friendlyCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

    - (void)addCard:(Card *)card atTop:(BOOL)atTop;
    - (void)addCard:(Card *)card;
    - (Card *)drawRandomCard;

@end
