//
//  RVPlatform.m
//  Joom
//
//  Created by Rohit Verma on 2014-07-22.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVPlatform.h"
#import "RVHelper.h"
static const uint32_t platformCat = 2;

@implementation RVPlatform



-(id)init:(CGSize)size{
    int rWIDTH = 1;


    self = [RVPlatform spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake([RVHelper generateRandNumber:rWIDTH :size], size.height/2)];
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = platformCat;
    return self;
}

-(id)setNewPosition:(CGPoint)position{
    [self setPosition:position];
    return self;
}

-(id)setSpriteAction:(SKAction*)action{
    [self runAction:action];
    return self;
}


-(id)setNewPositionAndRunAction:(int)positionAdd :(SKAction*)action{
    int height = [RVHelper generateRandNumber:3 :self.size];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if([defaults boolForKey:@"levelledPlatform"]){
        height = 0;
    }
    
    [self setPosition:CGPointMake(positionAdd+self.size.width/2, height)];
    [self runAction:action];
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
    
    RVPlatform *firstPlatform = [RVPlatform spriteNodeWithColor:[SKColor redColor] size:CGSizeMake([RVHelper generateRandNumber:rWIDTH :size], size.height/2)];
    self.position = CGPointMake(_prevPositionX+_prevWidth/2+_prevSpace+self.size.width/2, self.size.height/2);
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = platformCat;
    return firstPlatform;
    
}

+(void)overrideAction:(SKAction *)action{
    
    
}
@end
