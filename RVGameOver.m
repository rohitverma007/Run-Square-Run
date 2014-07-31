//
//  RVGameOver.m
//  Run Square Run
//
//  Created by Rohit Verma on 2014-07-27.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVGameOver.h"
#import "RVMyScene.h"
#import "RVButton.h"
#import "RVMainMenu.h"

//todo implement tap to retry, main menu button redirect, ugprade button redirect


@implementation RVGameOver
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        int currentScore = [defaults integerForKey:@"score"];
        int highScore = [defaults integerForKey:@"highScore"];
        int totalScore = [defaults integerForKey:@"totalScore"];
        int level = [defaults integerForKey:@"level"];
        level = ((totalScore - (totalScore%100)) / 100);
        
            [defaults setInteger:level forKey:@"level"];
        

        
        self.backgroundColor = [SKColor blackColor];
        SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        score.fontSize = 20;
        score.text = [NSString stringWithFormat:@"Score: %i | HighScore: %i | TotalScore: %i", currentScore, highScore, totalScore];
        score.position = CGPointMake(size.width/2, size.height-100);
        
        SKLabelNode *levelLabel = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        levelLabel.fontSize = 20;
        levelLabel.text = [NSString stringWithFormat:@"Level: %i | Pts to Next Level: %i", level, (100-(totalScore % 100))];
        levelLabel.position = CGPointMake(size.width/2, size.height-140);
        
        
        SKLabelNode *tapToPlay = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        tapToPlay.fontSize = 24;
        tapToPlay.text = [NSString stringWithFormat:@"Tap to Retry!"];
        tapToPlay.position = CGPointMake(size.width/2, 40);
        
        RVButton *menuButton = [[RVButton alloc] init:size :CGPointMake(size.width/5, size.height-40) :CGSizeMake(size.width/6, 50) :@"menuButton" :@"Main Menu"];

        RVButton *upgradeButton = [[RVButton alloc] init:size :CGPointMake(size.width-size.width/5, size.height-40) :CGSizeMake(size.width/6, 50) :@"upgradeButton" :@"Upgrade"];
        
        [self addChild:menuButton];
        [self addChild:upgradeButton];
        [self addChild:tapToPlay];
        [self addChild:levelLabel];
        [self addChild:score];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 
    

    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if([node.name isEqualToString:@"menuButton"]){
        RVMainMenu *mainMenu = [[RVMainMenu alloc] initWithSize:self.size];
        [self.scene.view presentScene: mainMenu];
    } else {
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:0.5];
        RVMyScene *newScene = [[RVMyScene alloc] initWithSize:self.size];
        [self.scene.view presentScene: newScene transition:reveal];
    }
    

    
    
}
@end
