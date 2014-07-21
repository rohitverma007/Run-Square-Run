//
//  RVMyScene.m
//  Joom
//
//  Created by Rohit Verma on 2014-07-19.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVMyScene.h"

static const uint32_t ballCat = 1;
static const uint32_t platformCat = 2;
static const uint32_t smallBlockCat = 4;
//static const uint32_t bigBallCat = 8;
@implementation RVMyScene
SKSpriteNode *ball;
//SKSpriteNode *platform;
SKSpriteNode *smallBlock;
BOOL touchingGround = NO;
SKSpriteNode *platform2;
BOOL addedPlatform = NO;

const int rWIDTH = 1;
const int rSPACE = 2;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor blackColor];
        self.physicsWorld.contactDelegate = self;
//        self.physicsWorld.gravity = CGVectorMake(0, 0);
        ball = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(15, 15)];
        ball.position = CGPointMake(ball.size.width/2, self.size.height/2);
        ball.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ball.size];
        ball.physicsBody.friction = 0;
        ball.physicsBody.categoryBitMask = ballCat;
        ball.physicsBody.contactTestBitMask = smallBlockCat | platformCat;
//        ball.physicsBody.velocity = CGVectorMake(10, 0);
//        [ball.physicsBody applyImpulse:CGVectorMake(20, 0)];
        [self generatePlatforms:size];
//        platform.physicsBody.velocity = CGVectorMake(-60, 0);
        
        smallBlock = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(5, 10)];
        smallBlock.position = CGPointMake(size.width/2, size.height/2+smallBlock.size.height/2);
        smallBlock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:smallBlock.size];
        smallBlock.physicsBody.dynamic = NO;
        smallBlock.physicsBody.categoryBitMask = smallBlockCat;
//        smallBlock.physicsBody.contactTestBitMask = smallBlockCat;
        NSLog(@"touched a brick body b");

        /* Called before each frame is rendered */
        SKAction *movePlatform = [SKAction moveBy:CGVectorMake(-100, 0) duration: 2];
        //    SKAction *scalePlatform = [SKAction scaleYTo:0.8 duration:20];
        //    SKAction *foreverG = [SKAction group:@[movePlatform, scalePlatform]];
        SKAction *forever = [SKAction repeatActionForever:movePlatform];
        //    [platform runAction:forever];
        [smallBlock runAction:forever];
        
        
        [self addChild:smallBlock];
        [self addChild:ball];

    }
    return self;
}


-(int)generateRandNumber:(int)rType :(CGSize)size{
    int randNumber = 0;
    int min = 50;
    if(rType == 1){ //Width
        randNumber = arc4random() % ((int)size.width - min) + 50;
    }
    if(rType == 2){ //Space
        randNumber = arc4random() % (150 - 50) +50;
    }
    return randNumber;
};




-(void) generatePlatforms:(CGSize)size{
    
//    for(int i = 0; i < 3; i++){
//    int randSpace = [self generateRandNumber:rSPACE :size];
    SKAction *movePlatform = [SKAction moveBy:CGVectorMake(-100, 0) duration: 2];
    SKAction *forever = [SKAction repeatActionForever:movePlatform];
    
    
    
    SKSpriteNode *platform = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake([self generateRandNumber:rWIDTH :size], size.height/2)];
    platform.position = CGPointMake(platform.size.width/2, platform.size.height/2);
    platform.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platform.size];
    platform.physicsBody.dynamic = NO;
    platform.physicsBody.categoryBitMask = platformCat;
    
    
    SKSpriteNode *platform1 = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake([self generateRandNumber:rWIDTH :size], size.height/2)];
    platform1.position = CGPointMake(platform.size.width+100+platform1.size.width/2, platform1.size.height/2);
    platform1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platform1.size];
    platform1.physicsBody.dynamic = NO;
    platform1.physicsBody.categoryBitMask = platformCat;
    
    
    platform2 = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake([self generateRandNumber:rWIDTH :size], size.height/2)];
    platform2.position = CGPointMake(platform.size.width+200+platform1.size.width+platform2.size.width/2, platform2.size.height/2);
    platform2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platform2.size];
    platform2.physicsBody.dynamic = NO;
    platform2.physicsBody.categoryBitMask = platformCat;
    platform2.name = @"lastPlatform";

    
    
    
//
//    
//    SKSpriteNode *platform2 = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(randWidth, size.height/2)];
//    platform2.position = CGPointMake(platform.size.width+randSpace+platform.size.width/2, platform1.size.height/2);
//    platform2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platform1.size];
//    platform2.physicsBody.dynamic = NO;
//    platform2.physicsBody.categoryBitMask = platformCat;

    NSLog(@"abcef %f, %f", platform.size.width, platform1.size.width);

    [platform runAction:forever];
    
    [platform1 runAction:forever];
    [platform2 runAction:forever];

    [self addChild:platform];
    [self addChild:platform1];
    [self addChild:platform2];

//    }

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    platform.physicsBody.velocity = platform.physicsBody.velocity;

    ball.physicsBody.velocity = CGVectorMake(0, 0);
    [ball.physicsBody applyImpulse:CGVectorMake(0, 3.5)];
//    [ball.physicsBody applyForce:CGVectorMake(0, 10)];
    
}


-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    SKPhysicsBody *notBall;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
        
        notBall = contact.bodyB;
        NSLog(@"touched a brick body b");
    } else {
        notBall = contact.bodyA;
        NSLog(@"touched a brick body a");
        
    }

    NSLog(@"touched a brick body a %@", notBall.node.name);
//    if(touchingGround == NO){
//    if([notBall.node.name  isEqual: @"lastPlatform"]){
//        touchingGround = YES;
//        [self generatePlatforms:self.frame.size];
//
//    }
//    }
//    [notBall.node removeFromParent];

    if(notBall.categoryBitMask == smallBlockCat){
        [notBall.node removeFromParent];
        SKAction *scaleBy = [SKAction scaleBy:1.3 duration:2];
        [ball runAction:scaleBy];
    }

    
}

-(void)update:(CFTimeInterval)currentTime {
    if(!addedPlatform){
    if(platform2.position.x < self.size.width){
        addedPlatform = YES;
        [self generatePlatforms:self.size]; //Change to generate platform (single)
    }
    }
}

@end
