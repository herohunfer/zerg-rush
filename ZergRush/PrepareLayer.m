#import "PrepareLayer.h"
#import "ZergRushLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

int timeToPlay;
CCLabelTTF *prepareLabel;
CCLabelTTF *timeoutLabel;

@implementation PrepareLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	PrepareLayer *layer = [PrepareLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

- (id) init
{
    if ((self = [super initWithColor:ccc4(0, 0, 0, 0)])) {
        //initial countdown timer
        timeToPlay = 4;
        CGSize s = [CCDirector sharedDirector].winSize;
        prepareLabel = [CCLabelTTF labelWithString:@"Prepare to play:" fontName:@"Marker Felt" fontSize:40];
        prepareLabel.position = ccp(s.width/2.0f, 300);
        [self addChild:prepareLabel];
        timeoutLabel = [CCLabelTTF labelWithString:@"3" fontName:@"Marker Felt" fontSize:60];
        timeoutLabel.position = ccp(s.width/2.0f, 240);
        [self addChild:timeoutLabel];
        prepareLabel.visible = YES;
        timeoutLabel.visible = YES;
        [self schedule:@selector(tick:) interval:1];

        
    }
    return self;
}

-(void) tick: (ccTime) dt {
    if (timeToPlay==1) [self play];
    else {
        timeToPlay--;
        NSString *countStr;
        
        if (timeToPlay==1) {
            countStr = [NSString stringWithFormat:@"GO!"];
        }
        else {
            countStr = [NSString stringWithFormat:@"%d", timeToPlay-1];
        }
        
        timeoutLabel.string = countStr;
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:countStr fontName:@"Marker Felt" fontSize:60];
        
        label.position = timeoutLabel.position;
        [self addChild:label z:1001];
        id scoreAction = [CCSequence actions:
                          [CCSpawn actions:
                          // [CCScaleBy actionwithDuration:0.4 scale:2.0],
                           [CCEaseIn actionWithAction:[CCFadeOut actionWithDuration:0.4] rate:2],
                           nil],
                          [CCCallBlock actionWithBlock:^{
                            [self removeChild:label cleanup:YES];
                        }],
                        nil];
        [label runAction:scoreAction];
    }
}

-(void) play {
 [[CCDirector sharedDirector] replaceScene:[ZergRushLayer scene]];
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
}


@end
