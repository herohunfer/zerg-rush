#import "cocos2d.h"
#import "Bunkers.h"

@interface Baddie : CCNode {
    CCSprite *baddie;
    int health;
    int strength;  // 0 for minon, 1 for boss
    boolean_t isAttacking;
}

-(id) init:(int) xcoord:(int) ycoord :(int) str;
-(boolean_t) hasReachedTarget: (Bunker*) target;
-(int) getNearestBunker:(Bunkers*) bunkers;
-(CGRect) getBoundingBox;
-(int) getx;
-(int) gety;
-(CGPoint) getPosition;
-(void) setPosition:(CGPoint) p;
-(int) reduceHealth;
-(void) showHealth;
-(void) setStrength:(int) str;
-(int) getStrength;
-(boolean_t) isAttacking;
-(void) setAttacking:(boolean_t) attacking;
@end