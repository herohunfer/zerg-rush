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

@end
