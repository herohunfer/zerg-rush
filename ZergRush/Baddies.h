#import "cocos2d.h"
#import "Baddie.h"

@interface Baddies : CCNode {
    NSMutableArray *baddies;
}

-(id) init;
-(void) addBaddie:(int)str;
-(void) addBaddie:(int)i :(int)str;
-(int) count;
-(void) removeBaddie: (id) baddie;
-(Baddie *) getBaddie: (int) index;
-(void) replace:(int) i: (Baddie*) newbaddie;
-(void) addBaddieWithPosition:(int)xCoor :(int)yCoor :(int)str;

@end