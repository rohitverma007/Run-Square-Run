#import "RVMainMenu.h"
#import "RVMyScene.h"

//TODO chekc for self.size refrences and make sure its fine to use
@implementation RVMainMenu
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        int highScore = (int)[defaults integerForKey:@"highScore"];
        int totalScore = (int)[defaults integerForKey:@"totalScore"];
                
        // Assign level property
        if([defaults objectForKey:@"level"] == nil){
            
            [defaults setInteger:1 forKey:@"level"];
            
        }
        
        int level = (int)[defaults integerForKey:@"level"];
        //Have to check modulus difference is not equal to 0 to
        //avoid overwriting level to 0 from previous level
        //TODO put this logic in a function/class? - move to RVHelper used in gameover scene as well

        if(totalScore > 0 && totalScore < 600){
            level = (totalScore - (totalScore%200))/200;
        } else if(totalScore >= 600 && totalScore < 1800){
            level = 3;
            int tempScore = totalScore - 600;
            level += (tempScore - (tempScore%400))/400;
        } else if(totalScore >= 1800){
            level = 6;
            int tempScore = totalScore - 1800;
            level += (tempScore - (tempScore%1000))/1000;
            if(level > 9){
                level = 9;
            }
        }

        if(level == 0 || (level == 1 & totalScore <200)){
            level = 1;
        } else {
            level++; //To make up for off by one error caused by <200%200 = 0
        }
//
//        if(level <= 3 && (totalScore - (totalScore%200)) / 200 != 0){
//            level = ((totalScore - (totalScore%200)) / 200);
//            if(level > 3){
//                level = 3;
//            }
//        } else if (level > 3 && level <= 5 && ((totalScore - (totalScore%400)) / 400)) {
//            level = ((totalScore - (totalScore%400)) / 400);
//            if(level > 5){
//                level = 5;
//            }
//        } else if (level > 5 && level < 10 && ((totalScore - (totalScore%1000)) / 1000)) {
//            level = ((totalScore - (totalScore%1000)) / 1000);
//            if(level > 10){
//                level = 10;
//            }
//        }
        [defaults setInteger:level forKey:@"level"];

        self.backgroundColor = [SKColor blackColor];

        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        title.fontSize = 24;
        title.text = [NSString stringWithFormat:@"Run Square Run!"];
        title.position = CGPointMake(size.width/2, size.height-50);
        
        [self addChild:title];
        
        
        SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        score.fontSize = 20;
        score.text = [NSString stringWithFormat:@"HighScore: %i | Total Score: %i | Health: %i", highScore, totalScore, level];
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
