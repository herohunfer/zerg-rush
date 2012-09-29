#import "cocos2d.h"
#import "Bunkers.h"

@interface Baddie : CCNode {
    CCSprite *baddie;
}

-(id) init:(int) xcoord:(int) ycoord;
-(int) getNearestBunker:(Bunkers*) bunkers;
-(CGRect) getBoundingBox;
@end