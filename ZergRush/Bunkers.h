#import "cocos2d.h"
#import "Bunker.h"

@interface Bunkers : CCNode {
    NSMutableArray *bunkers;
}

-(id) init;
-(int) count;
-(Bunker *) getBunker: (int) index;
-(void) removeBunker: (id) bunker;
@end