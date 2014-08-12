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
        level = ((totalScore - (totalScore%200)) / 200);
        [defaults setInteger:level forKey:@"level"];

        self.backgroundColor = [SKColor blackColor];

        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        title.fontSize = 24;
        title.text = [NSString stringWithFormat:@"Run Square Run!"];
        title.position = CGPointMake(size.width/2, size.height-50);
        
        [self addChild:title];
        
        
        SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        score.fontSize = 20;
        score.text = [NSString stringWithFormat:@"HighScore: %i | Total Score: %i | Health: %i", highScore, totalScore, 3+level];
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
