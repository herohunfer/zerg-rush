#import "Baddie.h"

@implementation Baddie
-(id) init: (int) xcoord: (int) ycoord {
    if ((self = [super init])) {
        baddie = [CCSprite spriteWithFile: @"baddie.png"];
        baddie.position = ccp(xcoord, ycoord);
        [self addChild:baddie];
    }
    return self;
}

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

@end