//
//  RVUpgradeMenu.m
//  Run Square Run
//
//  Created by Rohit Verma on 2014-07-31.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVUpgradeMenu.h"

@implementation RVUpgradeMenu

//TODO allow upgrading playerProperties through levelup points
//TODO this scene rendering tooo slow after toch or something?
-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
    
        self.backgroundColor = [SKColor blackColor];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *playerProperties = [defaults objectForKey:@"playerProperties"];
        
        SKLabelNode *availablePoints = [SKLabelNode labelNodeWithFontNamed:@""];
        availablePoints.position = CGPointMake(size.width/6, size.height-50);
        availablePoints.fontSize = 20;
        availablePoints.text = [NSString stringWithFormat:@"Points: %@", [playerProperties objectForKey:@"levelUpPoints"]];
        
        [self addChild:availablePoints];
        
        
    }
    return self;
}

@end
