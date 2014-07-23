//
//  RVPlatform.h
//  Joom
//
//  Created by Rohit Verma on 2014-07-22.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

BOOL lololol;
@interface RVPlatform : SKSpriteNode
-(id)init:(CGSize)size;
-(void) createFirstPlatform;
-(RVPlatform*) createNewPlatform;
-(int) generateRandNumber:(int)rType :(CGSize)size;
-(id)setNewPosition:(CGPoint)position;
-(id)setNewPositionAndRunAction:(int)positionAdd :(SKAction*)action;
@property (readwrite)int prevPositionX;
@property (readwrite)int prevWidth;
@property (readwrite)int prevSpace;
@end
