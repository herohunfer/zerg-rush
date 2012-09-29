#import "Baddie.h"
#import "Bunker.h"

@implementation Baddie
-(id) init: (int) xcoord: (int) ycoord {
    if ((self = [super init])) {
        baddie = [CCSprite spriteWithFile: @"baddie.png"];
        baddie.position = ccp(xcoord, ycoord);
        [self addChild:baddie];
    }
    return self;
}
/*
-(id) findTarget: {

}

-(Boolean) hasReachedTarget {
    Bunker *target = this.target;
    CGPoint pos = [target position];
    
    return  baddie.position.x >= pos.x &&
            baddie.position.y >= pos.y &&
            baddie.position.x <= pos.x + 10 &&
            baddie.position.y <= pos.y + 10;
 
}
*/
@end