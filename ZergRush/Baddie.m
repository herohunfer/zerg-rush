#import "Baddie.h"
#import "Bunker.h"

@implementation Baddie
-(id) init: (int) xcoord: (int) ycoord :(int) str{
    if ((self = [super init])) {
        baddie = [CCSprite spriteWithFile: @"baddie.png"];
        baddie.position = ccp(xcoord, ycoord);
        [self addChild:baddie];
        if (str == 1) health = 4;
        else health = 2;
        strength = str;
        [self setStrength :str];
        
    }
    return self;
}
/*
-(id) findTarget: {

}
 */

-(boolean_t) hasReachedTarget: (Bunker*) target {
    CGPoint pos = [target getPosition];
    
    return  (baddie.position.x >= pos.x &&
            baddie.position.y >= pos.y &&
            baddie.position.x <= (pos.x + 10) &&
            baddie.position.y <= (pos.y + 10));
 
}

-(int) getNearestBunker: (Bunkers*) bunkers {
    double shortestDistance = 723;
    int index = -1;
    
    for (int i=0; i < [bunkers count]; i++) {
        Bunker *cBunker = [bunkers getBunker:i];
        if (![cBunker getBunker].visible)
            {
                int bunkerX = [cBunker getx];
                int bunkerY = [cBunker gety];
    
                int baddieX = baddie.position.x;
                int baddieY = baddie.position.y;
        
                int dx = bunkerX - baddieX;
                int dy = bunkerY - baddieY;
        
                double distance = sqrtf(dx*dx + dy*dy);
                if (distance < shortestDistance) {
                    shortestDistance = distance;
                    index = i;
                }
            }
    }
    return index;
}
-(int) reduceHealth {
    return --health;
}
-(void) showHealth {
    if (health < 2)
    {
        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"yellowBaddie.png"];
        [baddie setTexture: tex];
    }
}

-(CGRect) getBoundingBox {
    return baddie.boundingBox;
}

-(int) getx {
    return baddie.position.x;
}
-(int) gety {
    return baddie.position.y;
}
-(CGPoint) getPosition {
        return baddie.position;
    }
-(void) setPosition:(CGPoint) p {
    baddie.position = p;
}
-(void) setStrength:(int) str {
    if (str == 1) {
        baddie.scaleX = 3;
        baddie.scaleY = 3;
    }
}
-(int) getStrength {
    return strength;
}

@end