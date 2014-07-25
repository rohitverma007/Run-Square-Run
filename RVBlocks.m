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
        blockSize = CGSizeMake(20, 10);
    }
    
    self = [RVBlocks spriteNodeWithColor:blockColor size:blockSize];
    self.position = CGPointMake(self.size.width/2+10+size.width, size.height/2+self.size.height/2); //Todo fix x position
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = category;
    
    return self;
}

-(id)setNewPositionAndRunAction:(int)positionAdd :(SKAction*)action :(CGSize)sSize :(bool)setMultipleLayer :(RVBlocks *)lastObject :(int)newLayerY{
    
    int xPos = positionAdd+self.size.width/2;
    int yPos = sSize.height/2+self.size.height/2;
    
    if(setMultipleLayer){
        yPos = newLayerY+20;
        xPos = lastObject.position.x-20;
    }
    
    
//    if(setMultipleLayer && !newLine){
//        yPos = lastObject.position.y+5+self.size.height/2+5;
//        xPos = lastObject.position.x;
//        newLine = true;
//    } else if(setMultipleLayer){
//        yPos = lastObject.position.y;
//        newLine = false;
//    }
    
    [self setPosition:CGPointMake(xPos, yPos)];
    [self runAction:action];
    return self;
}

@end
