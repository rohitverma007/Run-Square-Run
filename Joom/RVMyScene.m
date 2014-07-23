//
//  RVMyScene.m
//  Joom
//
//  Created by Rohit Verma on 2014-07-19.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

//TODO
//Look into optimizing.. fps decreases, cpu increases? memory management?
//Fix the generator, clean up code, check if good idea to put it in update? .. use similar logic as small/big blocks for loop?
//Fix ball moving back a bit?
//Implement random height, random space
//Implement smallBlocks, bigBlocks
//Implement power ups
//Implement score
//Implement main menu/ game over - retry
//Check difference between adding public variables here or in .h file...
//Remove platformCat?
//Hide status bar
//look into intenrary if statements/shortcut variable if statements



//1. fix jumping.. x appplyimpulse? but no velocity!
//TODO Automate first platform
//TODO Figure out how to set action properly... currently thinking of implementing delegates?
// Currently resetting action... should only modify it temporarily? maybe use callbacks???
#import "RVMyScene.h"
#import "RVPlatform.h"
#import "RVHelper.h"

static const uint32_t ballCat = 1;
static const uint32_t platformCat = 2;
static const uint32_t smallBlockCat = 4;
static const uint32_t bigBlockCat = 8;
@implementation RVMyScene
NSMutableArray *platformsArray;
SKSpriteNode *ball;
//SKSpriteNode *platform;
BOOL touchingGround = NO;
RVPlatform *platform;
RVPlatform *platform1;
SKSpriteNode *smallBlock;
SKSpriteNode *bigBlock;
RVPlatform *platform2;
SKLabelNode *score;
SKAction *forever;
BOOL addedPlatform = NO;
float totalWidth = 0;
float oldSize = 0;
float lastSmallBlockSize = 0;
float lastBigBlockSize = 0;
const int rWIDTH = 1;
const int rSPACE = 2;
int totalScore = 0;
BOOL appliedImpulse = false;
BOOL onAir = false;
int touched = 0;
//SKAction *movePlatform;


-(SKAction*)getAction{
    return forever;
}

-(void)setAction:(SKAction*)movePlat :(BOOL)isForever{
    
    SKAction* movePlatform = movePlat;
    if(isForever){
    forever = [SKAction repeatActionForever:movePlatform];
    } else {
        forever = movePlatform;
    }
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {

        
        
//        
//        SKSpriteNode *testing123  = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(100, 100)];
//        testing123.position = CGPointMake(size.width/2, size.height/2);
//
//        testing123.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:testing123.size];
////        testing123.physicsBody.dynamic = NO;
//        testing123.physicsBody.velocity = CGVectorMake(30, 0);
////        [testing123.physicsBody applyImpulse:CGVectorMake(50, 50)];
//        [self addChild:testing123];
//        [testing123 removeFromParent];
        self.backgroundColor = [SKColor blackColor];
        self.physicsWorld.contactDelegate = self;
        platformsArray = [NSMutableArray array];

        platform = [[RVPlatform alloc ]init:size];
        [platform setPosition:CGPointMake(platform.size.width/2, platform.size.height/2)];
        
        [self setAction:[SKAction moveBy:CGVectorMake(-100, 0) duration: 3] :true];

        [platform runAction:[self getAction]];
        [platformsArray addObject:platform];

        [platformsArray addObject:[[[RVPlatform alloc]init:self.size] setNewPositionAndRunAction:(int)([RVHelper getDistance:platformsArray.lastObject]) :[self getAction]]];
        
        [platformsArray addObject:[[[RVPlatform alloc]init:self.size] setNewPositionAndRunAction:(int)([RVHelper getDistance:platformsArray.lastObject]) :[self getAction]]];
        
        for(int i = 0; i < [platformsArray count]; i++){
            [self addChild:platformsArray[i]];
        }
        
        
//        self.physicsWorld.gravity = CGVectorMake(0, 0);
        ball = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(15, 15)];
        ball.position = CGPointMake(ball.size.width/2+5, self.size.height/2);
        ball.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ball.size];
        ball.physicsBody.friction = 0;
//        ball.physicsBody.restitution = 0;
        ball.physicsBody.categoryBitMask = ballCat;
        ball.physicsBody.contactTestBitMask = smallBlockCat | platformCat | bigBlockCat;
        ball.physicsBody.collisionBitMask = platformCat;
//        ball.physicsBody.velocity = CGVectorMake(90, 0);
        ball.physicsBody.allowsRotation = NO;
//        [ball.physicsBody applyImpulse:CGVectorMake(20, 0)];
//        [self generatePlatforms:size];
//        platform.physicsBody.velocity = CGVectorMake(-60, 0);

        [self generateSmallBlocks:size];
        [self generateBigBlocks:size];

        
        
        score = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Regular"];
        score.fontSize = 20;
        score.text = [NSString stringWithFormat:@"Score: %d", totalScore];
        score.position = CGPointMake(size.width/2, size.height-40);
//        score.position = CGPointMake(size.width, size.height);
        [self addChild:score];
//        smallBlock.physicsBody.contactTestBitMask = smallBlockCat;

        
        
        
        [self addChild:ball];

    }
    return self;
}

-(void)generateSmallBlocks:(CGSize)size{
    float oldSmallBlockSize = 0;
    for(int i = 0; i < 5; i++){
//        if(lastSmallBlockSize > 0){
//            smallBlock = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(10, 10)];
//            smallBlock.position = CGPointMake(lastSmallBlockSize+100+smallBlock.size.width/2, size.height/2+smallBlock.size.height/2);
//            smallBlock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:smallBlock.size];
//            smallBlock.physicsBody.dynamic = NO;
//            smallBlock.physicsBody.categoryBitMask = smallBlockCat;
//            oldSmallBlockSize = smallBlock.position.x+smallBlock.size.width;
//        } else {
        smallBlock = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(10, 10)];
        smallBlock.position = CGPointMake([self generateRandNumber:rSPACE :size], size.height/2+smallBlock.size.height/2);
        smallBlock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:smallBlock.size];
        smallBlock.physicsBody.dynamic = NO;
        smallBlock.physicsBody.categoryBitMask = smallBlockCat;
        oldSmallBlockSize = smallBlock.position.x+smallBlock.size.width;
//        }
        if(i == 4){
            smallBlock.name = @"lastSmallBlock";
            smallBlock.color = [SKColor blueColor];
            lastSmallBlockSize = smallBlock.position.x+smallBlock.size.width;
        }
        [smallBlock runAction:forever];
        [self addChild:smallBlock];
    }
}

-(void)generateBigBlocks:(CGSize)size{
    float oldBigBlockSize = 0;
    for(int i = 0; i < 5; i++){
        
//        if(i == 0){
//            bigBlock = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(10, 20)];
//            bigBlock.position = CGPointMake(lastSmallBlockSize+100+bigBlock.size.width/2, size.height/2+bigBlock.size.height/2);
//            bigBlock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bigBlock.size];
//            bigBlock.physicsBody.dynamic = NO;
//            bigBlock.physicsBody.categoryBitMask = bigBlockCat;
//            oldBigBlockSize = bigBlock.position.x+bigBlock.size.width;
//        } else {
            bigBlock = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(10, 20)];
            bigBlock.position = CGPointMake([self generateRandNumber:rSPACE :size], size.height/2+bigBlock.size.height/2);
            bigBlock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bigBlock.size];
            bigBlock.physicsBody.dynamic = NO;
            bigBlock.physicsBody.categoryBitMask = bigBlockCat;
            oldBigBlockSize = bigBlock.position.x+bigBlock.size.width;
//        }
        if(i == 4){
            bigBlock.name = @"lastBigBlock";
            bigBlock.color = [SKColor blueColor];
        }
        [bigBlock runAction:forever];
        [self addChild:bigBlock];
    }
}

-(int)generateRandNumber:(int)rType :(CGSize)size{
//    totalScore++;
    int randNumber = 0;
    int min = 50;
    if(rType == 1){ //Width
        randNumber = arc4random() % ((int)size.width - min) + 50;
    }
    if(rType == 2){ //Space
        randNumber = arc4random() % (int)size.width;
    }
    return randNumber;
};


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    platform.physicsBody.velocity = platform.physicsBody.velocity;
    [self setAction:[SKAction moveBy:CGVectorMake(-200, 0) duration: 1] :false];
//    SKAction *imStupid = [SKAction moveBy:CGVectorMake(-200, 0) duration: 0.4];
//    movePlatform = ;
    //    SKAction *scalePlatform = [SKAction scaleYTo:0.8 duration:20];
    //    SKAction *foreverG = [SKAction group:@[movePlatform, scalePlatform]];
//    forever = [SKAction repeatActionForever:movePlatform];
//    NSLog(@"%@", platformsArray[0]);
   for(int i = 0; i < [platformsArray count]; i++){
//        NSLog(@"%@", platformsArray[i]);
       [platformsArray[i] runAction:[self getAction]];
    }
    
    
    if(onAir == false){
        touched++;
        appliedImpulse = true;
//    ball.physicsBody.velocity = CGVectorMake(0, 0);
    [ball.physicsBody applyImpulse:CGVectorMake(0, 3)];
//        [platform.physicsBody applyImpulse:CGVectorMake(-20, 0)];
//                [platform1.physicsBody applyImpulse:CGVectorMake(-20, 0)];
//                [platform2.physicsBody applyImpulse:CGVectorMake(-20, 0)];
//        SKAction *movePlatform = [SKAction moveBy:CGVectorMake(-400, 0) duration: 2];
//        SKAction *forever = [SKAction repeatActionForever:movePlatform];
//
//        [platform runAction:forever];
//        [platform1 runAction:forever];
//        [platform2 runAction:forever];
//        ball.physicsBody.velocity = CGVectorMake(0, 0);

    }
//    [ball.physicsBody applyForce:CGVectorMake(0, 10)];
    
}


-(void)didBeginContact:(SKPhysicsContact *)contact{
    SKPhysicsBody *notBall;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
        
        notBall = contact.bodyB;
    } else {
        notBall = contact.bodyA;
        
    }


    if(notBall.categoryBitMask == smallBlockCat){
        [notBall.node removeFromParent];
        totalScore++;
        score.text = [NSString stringWithFormat:@"Score: %d", totalScore];
//        SKAction *scaleBy = [SKAction scaleBy:1.3 duration:2];
//        [ball runAction:scaleBy];
//        if(touched > 0){ //Put this if statement in the correct place!
//            ball.physicsBody.velocity = CGVectorMake(0, 0);
//        }
        if([notBall.node.name isEqualToString:@"lastSmallBlock"]){
            [self generateSmallBlocks:self.frame.size];
        }
    }
    
    //For now scale down? oo maybe scale down to original and then if one more touched, then die,
    // maybe in diferent mode , die by touching one?
    if(notBall.categoryBitMask == bigBlockCat){
        [notBall.node removeFromParent];
        totalScore--;
        score.text = [NSString stringWithFormat:@"Score: %d", totalScore];
//        SKAction *scaleBy = [SKAction scaleBy:0.8 duration:2];
//        [ball runAction:scaleBy];

//        if(touched > 0){ //Put this if statement in the correct place!
//            ball.physicsBody.velocity = CGVectorMake(0, 0);
//        }
        if([notBall.node.name isEqualToString:@"lastBigBlock"]){
            [self generateBigBlocks:self.frame.size];
        }
    }
    

    if(notBall.categoryBitMask == platformCat){
//                NSLog(@"Started Contact");
//        if(touched > 0){ //Put this if statement in the correct place!
//            ball.physicsBody.velocity = CGVectorMake(0, 0);
//        }
//        if(appliedImpulse == true){
            onAir = false;
//        }
    }
    
    
//        NSLog(@"%d", touched);
    
}

-(void)didEndContact:(SKPhysicsContact *)contact{
    SKPhysicsBody *notBall;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
        
        notBall = contact.bodyB;
    } else {
        notBall = contact.bodyA;
        
    }
    
    if(notBall.categoryBitMask == platformCat){
//        NSLog(@"Ended Contact");
       
//        if(appliedImpulse == true){

//        if(appliedImpulse == true){
//            touchedGround = false;
//        } else {
//            touchedGround = true;
//        }
    }
}

-(void)generatePlatforms{
//    movePlatform = [SKAction moveBy:CGVectorMake(-100, 0) duration: 2];
//    forever = [SKAction repeatActionForever:movePlatform];
//    NSLog(@"OOOOOOO %@ LOOOOOOOL", [self getAction]);
    [platformsArray addObject:[[[RVPlatform alloc]init:self.size] setNewPositionAndRunAction:(int)([RVHelper getDistance:platformsArray.lastObject]) :[self getAction]]];
    [self addChild:platformsArray.lastObject];
    [platformsArray addObject:[[[RVPlatform alloc]init:self.size] setNewPositionAndRunAction:(int)([RVHelper getDistance:platformsArray.lastObject]) :[self getAction]]];
    [self addChild:platformsArray.lastObject];
    
    [platformsArray addObject:[[[RVPlatform alloc]init:self.size] setNewPositionAndRunAction:(int)([RVHelper getDistance:platformsArray.lastObject]) :[self getAction]]];
    [self addChild:platformsArray.lastObject];
}

-(void)update:(CFTimeInterval)currentTime {
    NSLog(@"%lu", (unsigned long)platformsArray.count);

//    for(int i = 0; i < [platformsArray count]; i++){
////        [platformsArray[i] runAction:forever];
//    }
    
//    for(int i = 0; i < [platformsArray count]; i++){
//        //        NSLog(@"%@", platformsArray[i]);
////        [platformsArray[i] runAction:forever];
//        CGPoint abc = [platformsArray[i] position];
//        if(abc.x < 0){
//            [platformsArray removeObject:platformsArray[i]];
//        }
//    }
    
    CGPoint lastObject = [platformsArray.lastObject position];
//    CGSize  lastSize = [platformsArray.lastObject size];
//    if(lastObject.x < 0){
//        [platformsArray removeAllObjects];
//        
//    }
    NSLog(@"%@", platformsArray.lastObject);
    
    if(!addedPlatform){
        if(lastObject.x < self.size.width){
            
            

            addedPlatform = YES;
           
            
                    [self generatePlatforms]; //Change to generate platform (single)
        }
    }
    if(touched == 2){
        touched = 0;
        onAir = true;}
    
    if(addedPlatform){
        if(lastObject.x < self.size.width){

            addedPlatform = NO;
        }
    }
    
//    if(lastObject.x < 0){
//        [platformsArray removeLastObject];
//        NSLog(@"outside the dam ");
//    }
    
    
    if(platform.position.x+platform.size.width < self.size.width){
        
//        RVPlatform *platform;

        
        
        
        
        
    }
//    NSLog(@"%lu, lafkeofkoaekfoae", (unsigned long)platformsArray.count);


}

@end
