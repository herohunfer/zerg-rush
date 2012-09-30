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
        bunker = [CCSprite spriteWithFile: @"BlackIcon@2x.png"];
        [bunker setPosition:ccp(xcoord, ycoord)];
        
        if ([self hasRetinaDisplay]) {
            bunker.scaleX = 1.1;
            bunker.scaleY = 1.1;
        }
        else {
            bunker.scaleX = 0.55;
            bunker.scaleY = 0.55;
        }
        [self addChild:bunker];
        
        maxHealth = 60; // 60 fps * 5 baddies * 2 seconds for debug using 60, otherwise 600
        health = maxHealth;
        
        //health bar
        healthBarBorder = [CCSprite spriteWithFile:@"progressbarborder.png"];
        if ([self hasRetinaDisplay]) {
            healthBarBorder.scaleX = 0.8;
            healthBarBorder.scaleY = 0.8;
        }
        else {
            healthBarBorder.scaleX = 0.45;
            healthBarBorder.scaleY = 0.45;
        }
        [healthBarBorder setPosition:ccp(xcoord, ycoord-18)];
        [self addChild: healthBarBorder z:2];
        
        healthBar = [CCSprite spriteWithFile:@"progressbar.png"];
        healthBar.scaleX = 1;
        [healthBar setAnchorPoint:ccp(0, 0)];
        [healthBar setPosition:ccp(0, 0)];
        [healthBarBorder addChild: healthBar z:1];
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
-(int) reduceHealth:(int) str{
    if (str ==0) {
        --health;
        [self updateHealthBar];
        return health;
    }
    else {
        health -= 2;
        [self updateHealthBar];
        return health;
    }
}

-(BOOL)hasRetinaDisplay
{
    // checks for iPhone 4. will return a false positive on iPads, so use the above function in conjunction with this to determine if it's a 3GS or below, or an iPhone 4.
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
        return YES;
    else
        return NO;
}

//returns 1 for north, 2 for east, 3 for south, 4 for west
-(int) getWhichSideOfBunker:(CGPoint) p {
    int originX = bunker.boundingBox.origin.x;
    int originY = bunker.boundingBox.origin.y;
    
    int topY = originY + 57;
    int rightX = originX + 63;
    
    int px = p.x;
    int py = p.y;
    
    if (px <= originX && py <= topY && py >= originY) {
        return 4;
    }
    else if (px >= rightX && py <= topY && py >= originY) {
        return 2;
    }
    else if (py <= originY && px >= originX && px <= rightX) {
        return 3;
    }
    else if (py >= topY && px >= originX && px <= rightX) {
        return 1;
    }
    else {
        return 2;
    }
}

-(void) updateHealthBar {
    float healthRatio = (float)health/(float)maxHealth;
    healthBar.scaleX = healthRatio;
}

@end
