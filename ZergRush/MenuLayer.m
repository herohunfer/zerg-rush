//
//  MenuLayer.m
//  ZergRush
//
//  Created by Yan Wang on 9/29/12.
//
//

#import "MenuLayer.h"
#import "ZergRushLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

CCSprite *google2;
CCSprite *google3;
CCSprite *apple;

@implementation MenuLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

-(void) onNewGame {
    NSLog(@"on play");
    [[CCDirector sharedDirector] replaceScene:[ZergRushLayer scene]];
}
-(BOOL)hasRetinaDisplay
{
    // checks for iPhone 4. will return a false positive on iPads, so use the above function in conjunction with this to determine if it's a 3GS or below, or an iPhone 4.
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
        return YES;
    else
        return NO;
}

- (id) init
{
    if ((self = [super initWithColor:ccc4(0, 0, 0, 0)])) {
        
        CCMenuItemFont  *item1 =
        [CCMenuItemFont itemFromString:@"Start Game" target:self selector:@selector(onNewGame)];
        
        CCMenu *myMenu = [CCMenu menuWithItems: item1, nil];
        [self addChild: myMenu];
        
        CCSprite *zerg = [CCSprite spriteWithFile:@"zerg.png"];
        [self addChild:zerg];
        if (![self hasRetinaDisplay]) {
            zerg.scaleX = 0.9;
            zerg.scaleY = 0.9;
        }
        zerg.position = ccp(160, 350);
        // id rotate = [CCRotateBy actionWithDuration:4 angle:360];
        // id repeat = [CCRepeatForever actionWithAction:rotate];
        // [zerg runAction:repeat];
        
        
        // create and initialize our seeker sprite, and add it to this layer
        google2 = [CCSprite spriteWithFile: @"baddie.png"];
        google2.position = ccp( 60, 140 );
        [self addChild:google2];
        google3 = [CCSprite spriteWithFile: @"yellowBaddie.png"];
        google3.position = ccp( 80, 140 );
        [self addChild:google3];
        
        // do the same for our cocos2d guy, reusing the app icon as its image
        apple = [CCSprite spriteWithFile: @"apple.png"];
        apple.position = ccp( 200, 140 );
        [self addChild:apple];
        
        // schedule a repeating callback on every frame
        [self schedule:@selector(nextFrame:)];
    
    }
    return self;
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

- (void) nextFrame:(ccTime)dt {
    google2.position = ccp( google2.position.x + 80*dt, google2.position.y );
    if (google2.position.x > 480+32) {
        google2.position = ccp( -32, google2.position.y );
    }
    google3.position = ccp( google3.position.x + 80*dt, google3.position.y );
    if (google3.position.x > 480+32) {
        google3.position = ccp( -32, google3.position.y );
    }
    apple.position = ccp( apple.position.x + 80*dt, apple.position.y );
    if (apple.position.x > 480+32) {
        apple.position = ccp( -32, apple.position.y );
    }
}


@end
