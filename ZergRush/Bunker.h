//
//  Bunker.h
//  ZergRush
//
//  Created by Steven D Lebioda on 9/29/12.
//
//

#import "cocos2d.h"

@interface Bunker : CCNode {
    CCSprite *bunker;
    CCSprite *healthBarBorder;
    CCSprite *healthBar;
    int maxHealth;
    int health;
}

-(id) init:(int) xcoord:(int) ycoord;

-(CGRect) getBoundingBox;

-(int) getx;
-(int) gety;
-(CGPoint) getPosition;
-(int) getWhichSideOfBunker:(CGPoint) p;
-(CCSprite*) getBunker;
-(int) reduceHealth:(int) str;
-(void) updateHealthBar;
@end
