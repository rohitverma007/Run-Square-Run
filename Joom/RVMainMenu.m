//
//  RVMainMenu.m
//  Run Square Run
//
//  Created by Rohit Verma on 2014-07-27.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVMainMenu.h"
#import "RVMyScene.h"
#import "RVButton.h"
#import "RVUpgradeMenu.h"
//TODO chekc for self.size refrences and make sure its fine to use
@implementation RVMainMenu
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *playerProperties = @{
                                           @"health": [NSNumber numberWithInt:0],
                                           @"healthProgress" : [NSNumber numberWithInt:0],
                                           @"coinValue": [NSNumber numberWithInt:0],
                                           @"coinValueProgress": [NSNumber numberWithInt:0],
                                           @"coinFrequency": [NSNumber numberWithInt:0],
                                           @"redsDisabled": [NSNumber numberWithBool:false],
                                           @"redFrequency": [NSNumber numberWithInt:0],
                                           @"platformLevelled": [NSNumber numberWithBool:false],
                                           @"flyMode": [NSNumber numberWithBool:false],
                                           @"levelUpPoints": [NSNumber numberWithInt:0],
                                           @"colorChange": [NSNumber numberWithInt:0]
                                           };
        
        int highScore = [defaults integerForKey:@"highScore"];
        int totalScore = [defaults integerForKey:@"totalScore"];
        
        // Assign level property
        if([defaults objectForKey:@"level"] == nil){
            
            [defaults setInteger:1 forKey:@"level"];
            
        }
        
        int level = [defaults integerForKey:@"level"];
        level = ((totalScore - (totalScore%100)) / 100);
        
        [defaults setInteger:level forKey:@"level"];
        
        // Assign playerProperties dictionary
        if([defaults dictionaryForKey:@"playerProperties"] == nil){
            [defaults setObject:playerProperties forKey:@"playerProperties"];
        }
        
        NSLog(@"%i", level);

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
        
        SKLabelNode *levelLabel = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        levelLabel.fontSize = 20;
        levelLabel.text = [NSString stringWithFormat:@"Level: %i | Pts to Next Level: %i", level, (100-(totalScore % 100))];
        levelLabel.position = CGPointMake(size.width/2, size.height/2-30);
        
        
        RVButton *playButton = [[RVButton alloc] init:size :CGPointMake(size.width/5, 40) :CGSizeMake(size.width/3, 40) :@"playButton" :@"Play"];

        RVButton *upgradeButton = [[RVButton alloc] init:size :CGPointMake(size.width-playButton.position.x, 40) :CGSizeMake(size.width/3, 40) :@"upgradeButton" :@"Upgrade"];
        
        [self addChild:upgradeButton];
        [self addChild:playButton];
        [self addChild:levelLabel];
        [self addChild:score];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
//    RVMyScene *newScene = [[RVMyScene alloc] initWithSize:self.size];
//    [self.scene.view presentScene: newScene];
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if([node.name isEqualToString:@"playButton"]){
        RVMyScene *newScene = [[RVMyScene alloc] initWithSize:self.size];
        [self.scene.view presentScene: newScene];
    }
    
    if([node.name isEqualToString:@"upgradeButton"]){ //THIS IS TOO SLOW SLOWDINGG?
        RVUpgradeMenu *upgradeMenu = [[RVUpgradeMenu alloc] initWithSize:self.size];
        [self.scene.view presentScene: upgradeMenu];
    }
    
}

@end
