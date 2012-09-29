#import "Bunkers.h"

@implementation Bunkers
-(id) init {
    if ((self = [super init])) {
        bunkers = [[NSMutableArray alloc] init];

        int rowIconCount = 1;
        for (int height=0; height < 480; height+=96) {
            int colIconCount = 1;
            for (int width=0; width < 320; width+= 80) {
                
                int objectWidthPosition;
                int objectHeightPosition;
                
                if (colIconCount == 1) {
                    objectWidthPosition = width + 46;
                }
                else if (colIconCount == 2) {
                    objectWidthPosition = width + 42;
                }
                else if (colIconCount == 3) {
                    objectWidthPosition = width + 39;
                }
                else {
                    objectWidthPosition = width + 35;
                }
                
                if (rowIconCount == 1) {
                    objectHeightPosition = height + 50;
                }
                else if (rowIconCount == 2) {
                    objectHeightPosition = height + 58;
                }
                else if (rowIconCount == 3) {
                    objectHeightPosition = height + 50;
                }
                else if (rowIconCount == 4) {
                    objectHeightPosition = height + 42;
                }
                else {
                    objectHeightPosition = height + 34;
                }
                
                Bunker *bunker = [[Bunker alloc] init:objectWidthPosition:objectHeightPosition];
                [bunker getBunker].visible = false;
                
                [self addChild:bunker];
                
                [bunkers addObject: bunker];
                
                colIconCount++;
            }
            rowIconCount++;
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

-(void) removeBunker:(id)bunker {
    [bunkers removeObject:bunker];
    [self removeChild:bunker cleanup:YES];
    [bunker release];
}

@end