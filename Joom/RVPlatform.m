//
//  RVPlatform.m
//  Joom
//
//  Created by Rohit Verma on 2014-07-22.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVPlatform.h"
static const uint32_t platformCat = 2;

@implementation RVPlatform

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

-(id)init:(CGSize)size{
    int rWIDTH = 1;
    NSLog(@"%f, %d, %d LOOOl", size.width, self.prevPositionX, _prevPositionX);

//    return self;

    self = [RVPlatform spriteNodeWithColor:[SKColor redColor] size:CGSizeMake([self generateRandNumber:rWIDTH :size], size.height/2)];
//    self.position = CGPointMake(self.prevPositionX+self.prevWidth/2+self.prevSpace+self.size.width/2, self.size.height/2);
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
//    self.physicsBody.velocity = CGVectorMake(-40, 0);
//    [self.physicsBody applyImpulse:CGVectorMake(-40, 0)];
    self.physicsBody.categoryBitMask = platformCat;
    return self;
}

-(id)setNewPosition:(CGPoint)position{
//    self.position = position;
    [self setPosition:position];
    return self;
}

-(id)setSpriteAction:(SKAction*)action{
    [self runAction:action];
    return self;
}


-(id)setNewPositionAndRunAction:(int)positionAdd :(SKAction*)action{
    [self setPosition:CGPointMake(positionAdd+self.size.width/2, self.size.height/2)];
    [self runAction:action];
//    [scene addChild:self];
    return self;
}

-(void)createFirstPlatform{
    //TODO
}

-(RVPlatform *)createNewPlatform{
    return self;
}

-(RVPlatform*)createFirstPlatform:(CGSize)size {
    int rWIDTH = 1;
    
    RVPlatform *firstPlatform = [RVPlatform spriteNodeWithColor:[SKColor redColor] size:CGSizeMake([self generateRandNumber:rWIDTH :size], size.height/2)];
    self.position = CGPointMake(_prevPositionX+_prevWidth/2+_prevSpace+self.size.width/2, self.size.height/2);
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = platformCat;
    return firstPlatform;
    
}

+(void)overrideAction:(SKAction *)action{
//    [self setSpriteAction]
    
    
}
@end
