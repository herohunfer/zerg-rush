#import "Baddies.h"

@implementation Baddies
-(id) init {
    if ((self = [super init])) {
        baddies = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addBaddie {
    Baddie *baddie = [[Baddie alloc] init:100:100];
    [self addChild:baddie];
    [baddies addObject:baddie];
    /*CCSprite *baddie = [CCSprite spriteWithFile: @"baddie.png"];
    baddie.position = ccp(100, 100);
    [self addChild:baddie];
    [baddies addObject:baddie];*/
    
}

-(void) draw {
    for (int i=0; i < [baddies count]; i++) {
        
    }
}

@end