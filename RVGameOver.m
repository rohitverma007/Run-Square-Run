#import "RVGameOver.h"
#import "RVMyScene.h"
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
        score.text = [NSString stringWithFormat:@"Score: %i | HighScore: %i", currentScore, highScore];
        score.position = CGPointMake(size.width/2, size.height-100);
       
        SKLabelNode *nextLevel = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        nextLevel.fontSize = 18;
        nextLevel.text = [NSString stringWithFormat:@"Total Score: %i | Points to Next Health Upgrade: %i", totalScore, (200-(totalScore % 200))];
        nextLevel.position = CGPointMake(size.width/2, size.height-140);
        
        
        SKLabelNode *tapToPlay = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        tapToPlay.fontSize = 24;
        tapToPlay.text = [NSString stringWithFormat:@"Tap to Retry!"];
        tapToPlay.position = CGPointMake(size.width/2, 40);
        
        [self addChild:tapToPlay];
        [self addChild:nextLevel]; 
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
