//
//  ZergRushLayer.m
//  ZergRush
//
//  Created by Kaisen Chen on 9/28/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "ZergRushLayer.h"
#import "Baddies.h"
#import "Bunkers.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "CCTouchDispatcher.h"

#pragma mark - ZergRushLayer

Bunkers *bunkers;
Baddies *baddies;

// ZergRushLayer implementation
@implementation ZergRushLayer

// Helper class method that creates a Scene with the ZergRushLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ZergRushLayer *layer = [ZergRushLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
  
        //draw bunkers
        bunkers = [[Bunkers alloc] init];
        [self addChild:bunkers];

        //draw baddies (will need to change this to be more dynamic)
        baddies = [[Baddies alloc] init];
        
        
        
        [baddies addBaddie];
        [self addChild:baddies];
        
        // schedule a repeating callback on every frame
        [self schedule:@selector(nextFrame:)];
        
        self.isTouchEnabled = YES;
	}
	return self;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace: touch];
   /*
	[cocosGuy stopAllActions];
	[cocosGuy runAction: [CCMoveTo actionWithDuration:1 position:location]];
    */
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

- (void) nextFrame:(ccTime)dt {
    // loop through all the baddies
    for (int i = 0; i < 10; i++) {
        Baddie *currentBaddie = [baddies getBaddie:i];
        Bunker *nearestbunker = [bunkers getBunker:0];
        
        //int NearestBunkerIndex = [currentBaddie getNearestBunker:bunkers];
        //Bunker *nearestbunker = [bunkers getBunker:NearestBunkerIndex];
        
        int xDiff = ([nearestbunker getx]) - [currentBaddie getx];
        int yDiff = ([nearestbunker gety]) - [currentBaddie gety];
        double angle = atan2(yDiff, xDiff);
        
        [currentBaddie setPosition :ccp([currentBaddie getx]+1*cos(angle),[currentBaddie gety]+1*sin(angle))];
        [baddies replace:i :currentBaddie];
        if ([currentBaddie hasReachedTarget:nearestbunker] == true)
            nearestbunker.visible = false;
    }
}
@end
