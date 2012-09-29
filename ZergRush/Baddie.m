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

@end