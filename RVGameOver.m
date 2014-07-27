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
        long currentScore = [defaults integerForKey:@"score"];
        long highScore = [defaults integerForKey:@"highScore"];
        

        
        self.backgroundColor = [SKColor blackColor];
        SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        score.fontSize = 20;
        score.text = [NSString stringWithFormat:@"Score: %ld , HighScore: %ld", currentScore, highScore];
        score.position = CGPointMake(size.width/2, size.height/2);
        
        SKLabelNode *tapToPlay = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        tapToPlay.fontSize = 24;
        tapToPlay.text = [NSString stringWithFormat:@"Tap to Retry!"];
        tapToPlay.position = CGPointMake(size.width/2, 40);
        
        [self addChild:tapToPlay];
        
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
