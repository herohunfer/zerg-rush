#import "cocos2d.h"
#import "Baddie.h"

@interface Baddies : CCNode {
    NSMutableArray *baddies;
}

-(id) init;
-(void) addBaddie;
-(Baddie *) getBaddie: (int) index;
-(void) replace:(int) i: (Baddie*) newbaddie;

@end