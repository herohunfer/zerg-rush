#import "cocos2d.h"
#import "Baddie.h"

@interface Baddies : CCNode {
    NSMutableArray *baddies;
}

-(id) init;
-(void) addBaddie;
-(int) count;
-(Baddie *) getBaddie: (int) index;
-(void) removeBaddie: (id) baddie;
@end