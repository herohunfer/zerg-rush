#import "Bunkers.h"

@implementation Bunkers
-(id) init {
    if ((self = [super init])) {
        bunkers = [[NSMutableArray alloc] init];
        
        //initialize "iphone home screen" with 20 bunkers
        for (int i=0; i <= 20; i++) {
            CCSprite *bunkerSprite = [CCSprite spriteWithFile: @"bunker.png"];
            [bunkers addObject: bunkerSprite];
        }
        int bunkerIndex = 0;
        for (int height=0; height < 480; height+=96) {
            for (int width=0; width < 320; width+= 80) {
                CCSprite *bunkerSprite = [bunkers objectAtIndex:bunkerIndex];
                
                int objectWidthPosition = width + 40;
                int objectHeightPosition = height + 48;
                
                bunkerSprite.position = ccp(objectWidthPosition, objectHeightPosition);
                [self addChild:bunkerSprite];
                bunkerIndex++;
            }
        }
    }
    return self;
}

@end