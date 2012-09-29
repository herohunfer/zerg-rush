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
-(int) getNearestBunker: (Bunkers*) bunkers {
    double shortestDistance;
    int index;
    
    for (int i=0; i < [bunkers count]; i++) {
        Bunker *bunker = [bunkers getBunker:i];
        int bunkerX = [bunker position].x;
        int bunkerY = [bunker position].y;
    
        int baddieX = [baddie position].x;
        int baddieY = [baddie position].y;
        
        int dx = bunkerX - baddieX;
        int dy = bunkerY - baddieY;
        
        double distance = sqrt(dx*dx + dy*dy);
        if (distance < shortestDistance) {
            shortestDistance = distance;
            index = i;
        }
    }
    return index;
}

-(CGRect) getBoundingBox {
    return baddie.boundingBox;
}

@end