//
//  Bunker.m
//  ZergRush
//
//  Created by Steven D Lebioda on 9/29/12.
//
//

#import "Bunker.h"

@implementation Bunker
-(id) init:(int) xcoord: (int) ycoord {
    if ((self = [super init])) {
        bunker = [CCSprite spriteWithFile: @"bunker.png"];
        bunker.position = ccp(xcoord, ycoord);
        [self addChild:bunker];
    }
    return self;
}
@end
