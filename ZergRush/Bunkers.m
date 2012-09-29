#import "Bunkers.h"

@implementation Bunkers
-(id) init {
    if ((self = [super init])) {
        bunkers = [[NSMutableArray alloc] init];

        for (int height=0; height < 480; height+=96) {
            for (int width=0; width < 320; width+= 80) {
                
                int objectWidthPosition = width + 40;
                int objectHeightPosition = height + 48;
                Bunker *bunker = [[Bunker alloc] init:objectWidthPosition:objectHeightPosition];
                
                [self addChild:bunker];
                
                [bunkers addObject: bunker];
                

            }
        }
    }
    return self;
}

-(int) count {
    return [bunkers count];
}

-(Bunker *) getBunker:(int)index {
    return [bunkers objectAtIndex:index];
}

@end