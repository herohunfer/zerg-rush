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
#import "IntroLayer.h"
#import "MenuLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "CCTouchDispatcher.h"

#pragma mark - ZergRushLayer

Bunkers *bunkers;
Baddies *baddies;
Boolean isEnd = false;
int timeCount = -1;
int base = 180;
int bossBase = 300;
Boolean flag = false;
Boolean activePower = false;
CCSprite *apple;

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



-(void) onPower {
    NSLog(@"on power");
    if (power > 0 && !activePower) {
        power -= 25;
        [powerLabel setString:[NSString stringWithFormat:@"%i%%", power]];
        
        apple = [CCSprite spriteWithFile: @"apple.png"];
        apple.position = ccp( 160, 480 );
        apple.scaleX = 2;
        apple.scaleY = 2;
        [self addChild:apple];
        activePower =true;
    }
    
    
}



// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        //background
        CCSprite *background;
        CGSize size = [[CCDirector sharedDirector] winSize];
        if ([self hasRetinaDisplay]) {
            background = [CCSprite spriteWithFile:@"photo.PNG"];
        }
        else {
            background = [CCSprite spriteWithFile:@"photo-lowres.png"];
        }
        // }
        background.position = ccp(size.width/2, size.height/2);
        
        // add the label as a child to this Layer
        [self addChild: background];
        
        activePower = false;
        
        // power menu
        CCMenuItemImage  *item1 =
        [CCMenuItemImage itemWithNormalImage:@"apple.png" selectedImage:@"apple.png" target:self selector:@selector(onPower)];
        if ([self hasRetinaDisplay]) {
            item1.scaleX = 0.8;
            item1.scaleY = 0.8;
        }
        else {
            item1.scaleX = 0.4;
            item1.scaleY = 0.4;
        }
        item1.position = ccp(300-160, 470-240);
        // item1.opacity = 100;
        CCMenu *myMenu = [CCMenu menuWithItems: item1, nil];
        [self addChild: myMenu];
        
        
        
        //draw bunkers
        bunkers = [[Bunkers alloc] init];
        [self addChild:bunkers];

        //draw baddies (will need to change this to be more dynamic)
        baddies = [[Baddies alloc] init];
        
        //set flag
        //flag = true;
        
        //[baddies addBaddie];
        [self addChild:baddies];
        
        // schedule a repeating callback on every frame
        [self schedule:@selector(nextFrame:)];
        
        //score label
        score = 0;
        scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Zerglings killed: %i", score] fontName:@"Helvetica Neue" fontSize:13];
        scoreLabel.position = ccp(165, 470);
        [self addChild:scoreLabel z:1];
        
        //power label
        power = 100;
        powerLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i %%", power] fontName:@"Helvetica Neue" fontSize:13];
        powerLabel.position = ccp(240, 470);
        [self addChild:powerLabel z:1];
        
        
        self.isTouchEnabled = YES;
        
        // for the end of game
        
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
    NSSet *allTouches = [event allTouches]; //Get all the current touches in the event
    UITouch *aTouch = [allTouches anyObject]; //Get one of the touches, multitouch is disabled, so there is only always going to be one.
    CGPoint pos = [aTouch locationInView:touch.view]; //Get the location of the touch
    CGPoint ccPos = [[CCDirector sharedDirector] convertToGL:pos];
    //Convert that location to something cocos2d can use
    
    //check all baddies
    for (int i=0; i < [baddies count]; i++) {
        Baddie* baddie = [baddies getBaddie:i];
        if (CGRectContainsPoint([baddie getBoundingBox], ccPos)) //Method to check if a rectangle contains a point
        {
            //bunker.visible = NO; //Make your sprite invisible
            if ([baddie reduceHealth] <= 0)
            {
                score++;
                [scoreLabel setString:[NSString stringWithFormat:@"Zerglings killed: %i", score]];
                int str = [baddie getStrength];
                if (str == 1) {
                    CGPoint pos = [baddie getPosition];
                    [baddies addBaddieWithPosition:(pos.x - 30) :(pos.y-10) :0];
                    [baddies addBaddieWithPosition:(pos.x + 30) :(pos.y+10) :0];
                }
                [baddies removeBaddie:baddie];
            }
            else [baddie showHealth];    //change the color of the baddies
            // break;
        }
    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
    //reset all the attributes
    isEnd = false;
    timeCount = -1;
    base = 180;
    bossBase = 600;
    flag = false;
    score = 0;
    activePower = false;
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

-(BOOL)hasRetinaDisplay
{
    // checks for iPhone 4. will return a false positive on iPads, so use the above function in conjunction with this to determine if it's a 3GS or below, or an iPhone 4.
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
        return YES;
    else
        return NO;
}
/*
-(void) setScoreString {
    [scoreString setString:@"Zerglings killed: "];
    [scoreString appendString:[[NSNumber numberWithInt:score] stringValue]];
}
 */

- (void) nextFrame:(ccTime)dt {
    
    // POWER STAGE
    if (activePower) {
        apple.position = ccp( apple.position.x, apple.position.y - 10);
        if (apple.position.y < -32) {
            while ([baddies count] > 0) {
                int i = [baddies count] -1;
                [baddies removeBaddie:[baddies getBaddie:i]];
            }
            [self removeChild:apple cleanup:YES];
            activePower = false;
        }
    }
    // loop through all the baddies
    if (!isEnd)
    {
        timeCount++;
        if (timeCount % base == 0) {
            [baddies addBaddie:((timeCount / base) % 6 / 3) :0]; // 3 per direction
        }
        if (timeCount % bossBase == 0) {
            [baddies addBaddie:((timeCount / bossBase) % 2) :1]; // 3 per direction
        }
        
        if (timeCount % 600 == 0 && base > 30)
            base-=30;
        // add apple power every 30 secs
        if (timeCount % 600 == 0 && power < 100) {
            power+=25;
            [powerLabel setString:[NSString stringWithFormat:@"%i%%", power]];
        }
        
        for (int i = 0; i < [baddies count]; i++) {
            Baddie *currentBaddie = [baddies getBaddie:i];
            int str = [currentBaddie getStrength];
            //Bunker *nearestbunker = [bunkers getBunker:0];
            if ([currentBaddie getStrength] ==0 || timeCount % 2 == 0) {
                int NearestBunkerIndex = [currentBaddie getNearestBunker:bunkers];
                if (NearestBunkerIndex < 0) {
                    isEnd = true;
                    flag = true;
                }
                else {
                    Bunker *nearestbunker = [bunkers getBunker:NearestBunkerIndex];
                    
                    int xDiff = ([nearestbunker getx]) - [currentBaddie getx];
                    int yDiff = ([nearestbunker gety]) - [currentBaddie gety];
                    double angle = atan2(yDiff, xDiff);
                    
                    CGPoint newPosition = ccp([currentBaddie getx]+2*cos(angle),[currentBaddie gety]+2*sin(angle));
                    if (!CGRectContainsPoint([nearestbunker getBoundingBox], newPosition)) {
                        [currentBaddie setPosition:newPosition];
                    }
                    else {
                        if ([currentBaddie isAttacking]) {
                            //don't move
                        }
                        else {
                            //move anyway and set attacking
                            [currentBaddie setPosition:newPosition];
                            [currentBaddie setAttacking:YES];
                        }
                    }
                    
                    if ([currentBaddie hasReachedTarget:nearestbunker] == true) {
                        if ([nearestbunker reduceHealth:str] <= 0) {
                            [nearestbunker getBunker].visible = true;
                            [baddies setAllAttacking:NO];
                        }
                    }
                }
            }
        }
    }
    
    else
    {
        while ([baddies count] > 0) {
            int i = [baddies count] -1;
            [baddies removeBaddie:[baddies getBaddie:i]];
        }
        while ([baddies count] < 20)
            [baddies addBaddie :0:0];
        
        for (int i = 0; i < [baddies count]; i++) {
            Baddie *currentBaddie = [baddies getBaddie:i];
            //all gone. game end. Empty the baddies.
            if ((i / 10) == 1)
            {
                [currentBaddie reduceHealth];
                [currentBaddie showHealth];
            }
            switch (i) {
                case 0:
                    [currentBaddie setPosition :ccp(40, 210)];
                    break;
                case 1:
                    [currentBaddie setPosition :ccp(30, 240)];
                    break;
                case 2:
                    [currentBaddie setPosition :ccp(40, 270)];
                    break;
                case 3:
                    [currentBaddie setPosition :ccp(70, 300)];
                    break;
                case 4:
                    [currentBaddie setPosition :ccp(130, 300)];
                    break;
                case 5:
                    [currentBaddie setPosition :ccp(130, 210)];
                    break;
                case 6:
                    [currentBaddie setPosition :ccp(130, 240)];
                    break;
                case 7:
                    [currentBaddie setPosition :ccp(100, 240)];
                    break;
                case 8:
                    [currentBaddie setPosition :ccp(110, 180)];
                    break;
                case 9:
                    [currentBaddie setPosition :ccp(70, 180)];
                    break;
                case 10:
                    [currentBaddie setPosition :ccp(200, 210)];
                    break;
                case 11:
                    [currentBaddie setPosition :ccp(190, 240)];
                    break;
                case 12:
                    [currentBaddie setPosition :ccp(200, 270)];
                    break;
                case 13:
                    [currentBaddie setPosition :ccp(230, 300)];
                    break;
                case 14:
                    [currentBaddie setPosition :ccp(290, 300)];
                    break;
                case 15:
                    [currentBaddie setPosition :ccp(290, 210)];
                    break;
                case 16:
                    [currentBaddie setPosition :ccp(290, 240)];
                    break;
                case 17:
                    [currentBaddie setPosition :ccp(260, 240)];
                    break;
                case 18:
                    [currentBaddie setPosition :ccp(270, 180)];
                    break;
                case 19:
                    [currentBaddie setPosition :ccp(230, 180)];
                    break;
                    
                default:
                    break;
            }
        }
        if (flag) {
            flag = false;
            CCMenuItemFont  *item1 =
            [CCMenuItemFont itemFromString:@"Good Game!" target:self selector:@selector(onNewGame)];
            item1.position =ccp(0, -90);
            
            CCMenu *myMenu = [CCMenu menuWithItems: item1, nil];
            [self addChild: myMenu];
        }
    }
    // } //flag if close
    // else flag = !flag;
}
-(void) onNewGame {
    NSLog(@"on replay");
    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
}
@end
