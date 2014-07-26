//
//  RVBlocks.h
//  Joom
//
//  Created by Rohit Verma on 2014-07-23.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface RVBlocks : SKSpriteNode
@property bool isSmall;
-(id)init:(CGSize)size :(bool)isSmall;
-(id)setNewPositionAndRunAction:(int)positionAdd :(SKAction*)action :(CGSize)sSize :(bool)setMultipleLayer :(RVBlocks *)lastObject :(int)newLayerY :(bool)isSmall;
@end
