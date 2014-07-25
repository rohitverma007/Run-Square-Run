//
//  RVBlocks.m
//  Joom
//
//  Created by Rohit Verma on 2014-07-23.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVBlocks.h"
#import "RVHelper.h"
@implementation RVBlocks
static const uint32_t smallBlockCat = 4;
static const uint32_t bigBlockCat = 8;

//TODO 
-(id)init:(CGSize)size :(bool)isSmall{
    CGSize blockSize;
    uint32_t category = 0;
    SKColor *blockColor;
    
    if(isSmall){
        category = smallBlockCat;
        blockColor = [SKColor greenColor];
        blockSize = CGSizeMake(15, 15);
    } else {
        category = bigBlockCat;
        blockColor = [SKColor redColor];
        blockSize = CGSizeMake(30, 30);
    }
    
    self = [RVBlocks spriteNodeWithColor:[SKColor greenColor] size:blockSize];
    self.position = CGPointMake([RVHelper generateRandNumber:2 :size], size.height/2+self.size.height/2); //Todo fix x position
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = category;
    
    return self;
}

-(id)setNewPositionAndRunAction:(int)positionAdd :(SKAction*)action :(CGSize)sSize{
    [self setPosition:CGPointMake(positionAdd+self.size.width/2, sSize.height/2+self.size.height/2)];
    [self runAction:action];
    return self;
}

@end
