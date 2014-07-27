//
//  RVMainMenu.m
//  Run Square Run
//
//  Created by Rohit Verma on 2014-07-27.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVMainMenu.h"
#import "RVMyScene.h"
@implementation RVMainMenu

-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        long highScore = [defaults integerForKey:@"highScore"];
        
        
        
        self.backgroundColor = [SKColor blackColor];
        SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        score.fontSize = 20;
        score.text = [NSString stringWithFormat:@"HighScore: %ld, Tap to Play!", highScore];
        score.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:score];
    }
    return self;
}

@end
