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
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        int highScore = [defaults integerForKey:@"highScore"];
        int totalScore = [defaults integerForKey:@"totalScore"];
        self.backgroundColor = [SKColor blackColor];
        
        
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        title.fontSize = 24;
        title.text = [NSString stringWithFormat:@"Run Square Run!"];
        title.position = CGPointMake(size.width/2, size.height-50);
        
        [self addChild:title];
        
        
        SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        score.fontSize = 20;
        score.text = [NSString stringWithFormat:@"HighScore: %i | TotalScore: %i", highScore, totalScore];
        score.position = CGPointMake(size.width/2, size.height/2);
        SKLabelNode *tapToPlay = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        tapToPlay.fontSize = 24;
        tapToPlay.text = [NSString stringWithFormat:@"Tap to Play!"];
        tapToPlay.position = CGPointMake(size.width/2, 40);
        
        [self addChild:tapToPlay];
        [self addChild:score];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    RVMyScene *newScene = [[RVMyScene alloc] initWithSize:self.size];
    [self.scene.view presentScene: newScene];
    
    
    
}

@end
