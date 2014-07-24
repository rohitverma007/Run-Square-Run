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
    if(isSmall){
        blockSize = CGSizeMake(15, 15);
    } else {
        blockSize = CGSizeMake(30, 30);
    }
    
    self = [RVBlocks spriteNodeWithColor:[SKColor greenColor] size:blockSize];
    self.position = CGPointMake([RVHelper generateRandNumber:2 :size], size.height/2+self.size.height/2); //Todo fix x position
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = smallBlockCat;
    
    return self;
}
@end
