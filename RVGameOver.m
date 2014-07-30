//
//  RVGameOver.m
//  Run Square Run
//
//  Created by Rohit Verma on 2014-07-27.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVGameOver.h"
#import "RVMyScene.h"

@implementation RVGameOver
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        int currentScore = [defaults integerForKey:@"score"];
        int highScore = [defaults integerForKey:@"highScore"];
        int totalScore = [defaults integerForKey:@"totalScore"];
        int level = [defaults integerForKey:@"level"];

        if(totalScore % (100) == 0){
            level++;
            [defaults setInteger:level forKey:@"level"];
        }

        
        self.backgroundColor = [SKColor blackColor];
        SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        score.fontSize = 20;
        score.text = [NSString stringWithFormat:@"Score: %i | HighScore: %i | TotalScore: %i", currentScore, highScore, totalScore];
        score.position = CGPointMake(size.width/2, size.height-10);
        
        SKLabelNode *levelLabel = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        levelLabel.fontSize = 20;
        levelLabel.text = [NSString stringWithFormat:@"Level: %i | Pts to Next Level: %i", level, (100-(totalScore % 100))];
        levelLabel.position = CGPointMake(size.width/2, size.height-40);
        
        
        SKLabelNode *tapToPlay = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        tapToPlay.fontSize = 24;
        tapToPlay.text = [NSString stringWithFormat:@"Tap to Retry!"];
        tapToPlay.position = CGPointMake(size.width/2, 40);
        
        [self addChild:tapToPlay];
        [self addChild:levelLabel];
        [self addChild:score];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 
    
    SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:0.5];
    RVMyScene *newScene = [[RVMyScene alloc] initWithSize:self.size];
    [self.scene.view presentScene: newScene transition:reveal];
    
    
    
}
@end
