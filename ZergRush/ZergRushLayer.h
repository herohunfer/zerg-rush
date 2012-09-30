//
//  BunkerLayer.h
//  ZergRush
//
//  Created by Kaisen Chen on 9/28/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface ZergRushLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    int score;
    NSMutableString* scoreString;
    CCLabelTTF* scoreLabel;
}

// returns a CCScene that contains the ZergRushLayer as the only child
+(CCScene *) scene;

@end
