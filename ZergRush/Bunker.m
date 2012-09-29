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
        [bunker setPosition:ccp(xcoord, ycoord)];
        [self addChild:bunker];
    }
    return self;
}

-(CCSprite*) getBunker {
    return bunker;
}


-(CGRect) getBoundingBox {
    return bunker.boundingBox;
}


-(int) getx {
    return bunker.position.x;
}
-(int) gety {
    return bunker.position.y;
}

-(CGPoint) getPosition {
    return bunker.position;
}

@end
