//
//  RVUpgradeMenu.m
//  Run Square Run
//
//  Created by Rohit Verma on 2014-07-31.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVUpgradeMenu.h"

@implementation RVUpgradeMenu

int levelUpPoints;
NSDictionary *playerProperties;

//TODO allow upgrading playerProperties through levelup points
//TODO this scene rendering tooo slow after toch or something?
-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
    
        self.backgroundColor = [SKColor blackColor];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        playerProperties = [defaults objectForKey:@"playerProperties"];
        
        SKLabelNode *availablePoints = [SKLabelNode labelNodeWithFontNamed:@""];
        availablePoints.position = CGPointMake(size.width/6, size.height-50);
        availablePoints.fontSize = 20;
        availablePoints.text = [NSString stringWithFormat:@"Points: %@", [playerProperties objectForKey:@"levelUpPoints"]];
        
            NSLog(@"out %@", [playerProperties objectForKey:@"levelUpPoints"]);
        
        [playerProperties setValue:[NSNumber numberWithInt:5] forKey:@"levelUpPoints"];
        NSLog(@"after %@", [playerProperties objectForKey:@"levelUpPoints"]);

        if([playerProperties objectForKey:@"levelUpPoints"] > 0){
            levelUpPoints = (int)[playerProperties objectForKey:@"levelUpPoints"];
            SKLabelNode *healthPlus = [SKLabelNode labelNodeWithFontNamed:@""];
            healthPlus.position = CGPointMake(size.width/6, size.height-70);
            healthPlus.fontSize = 20;
            healthPlus.text = [NSString stringWithFormat:@"+"];
            healthPlus.name = @"healthPlus";
            
            [self addChild:healthPlus];
        }
        

        
        [self addChild:availablePoints];
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    //    RVMyScene *newScene = [[RVMyScene alloc] initWithSize:self.size];
    //    [self.scene.view presentScene: newScene];
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if([node.name isEqualToString:@"healthPlus"]){
        levelUpPoints--;
        [playerProperties setValue:[NSNumber numberWithInt:levelUpPoints] forKey:@"levelUpPoints"];

        NSLog(@"touched");
    }
    

    
}

@end
