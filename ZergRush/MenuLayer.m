//
//  MenuLayer.m
//  ZergRush
//
//  Created by Yan Wang on 9/29/12.
//
//

#import "MenuLayer.h"
#import "ZergRushLayer.h"

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
- (id) init
{
    if ((self = [super initWithColor:ccc4(0, 255, 0, 255)])) {
        // CCLabelTTF *titleLeft = [CCLabelTTF labelWithString:@"Menu " fontName:@"Marker Felt" fontSize:48];
        CCMenuItemFont  *item1 =
        [CCMenuItemFont itemFromString:@"Start Game" target:self selector:@selector(onNewGame)];
        
        CCMenu *myMenu = [CCMenu menuWithItems: item1, nil];
        [self addChild: myMenu];
    
    }
    return self;
}


@end
