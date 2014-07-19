//
//  RVMyScene.m
//  Joom
//
//  Created by Rohit Verma on 2014-07-19.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVMyScene.h"

@implementation RVMyScene
SKSpriteNode *ball;
SKSpriteNode *platform;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor blackColor];

//        self.physicsWorld.gravity = CGVectorMake(0, 0);
        ball = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(20, 20)];
        ball.position = CGPointMake(ball.size.width/2, self.size.height/2);
        ball.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ball.size];
        ball.physicsBody.velocity = CGVectorMake(10, 0);
//        [ball.physicsBody applyImpulse:CGVectorMake(20, 0)];
        ball.physicsBody.friction = 0;
        platform = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(size.width*1.2, size.height/2)];
        platform.position = CGPointMake(platform.size.width/2, platform.size.height/2);
        platform.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platform.size];
        platform.physicsBody.dynamic = NO;
        platform.physicsBody.velocity = CGVectorMake(-60, 0);
        
        [self addChild:ball];
        [self addChild:platform];
        
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
//    ball.physicsBody.velocity = self.physicsBody.velocity;
    [ball.physicsBody applyImpulse:CGVectorMake(0, 5)];
    platform.physicsBody.velocity = self.physicsBody.velocity;
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
