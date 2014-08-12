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
        int pointsToNextLevel = 0;
        
        if(totalScore > 0 && totalScore < 600){
            level = (totalScore - (totalScore%200))/200;
            pointsToNextLevel = (200 - (totalScore % 200));
        } else if(totalScore >= 600 && totalScore < 1800){
            level = 3;
            int tempScore = totalScore - 600;
            level += (tempScore - (tempScore%400))/400;
            pointsToNextLevel = (400 - (tempScore % 400));
        } else if(totalScore >= 1800){
            level = 6;
            int tempScore = totalScore - 1800;
            level += (tempScore - (tempScore%1000))/1000;
            pointsToNextLevel = (1000 - (tempScore % 1000));
            if(level > 9){
                level = 9;
            }
        }
        
        if(level != 1){
        level++; //To make up for off by one error caused by <200%200 = 0
        }
        [defaults setInteger:level forKey:@"level"];
        


        self.backgroundColor = [SKColor blackColor];
        SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        score.fontSize = 20;
        score.text = [NSString stringWithFormat:@"Score: %i | HighScore: %i", currentScore, highScore];
        score.position = CGPointMake(size.width/2, size.height-100);
       
        SKLabelNode *nextLevel = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        nextLevel.fontSize = 18;
        if(level >= 10){
            nextLevel.text = [NSString stringWithFormat:@"Total Score: %i | Max Health Reached!", totalScore];
        } else {
        nextLevel.text = [NSString stringWithFormat:@"Total Score: %i | Points to Next Health Upgrade: %i", totalScore, pointsToNextLevel];
        }
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
