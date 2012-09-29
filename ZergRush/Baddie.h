#import "cocos2d.h"
#import "Bunkers.h"

@interface Baddie : CCNode {
    CCSprite *baddie;
    int health;
    
}

-(id) init:(int) xcoord:(int) ycoord;
-(boolean_t) hasReachedTarget: (Bunker*) target;
-(int) getNearestBunker:(Bunkers*) bunkers;
-(CGRect) getBoundingBox;
-(int) getx;
-(int) gety;
-(CGPoint) getPosition;
-(void) setPosition:(CGPoint) p;
-(int) reduceHealth;
-(void) showHealth;

@end