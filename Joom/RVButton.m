//
//  RVButton.m
//  Run Square Run
//
//  Created by Rohit Verma on 2014-07-31.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVButton.h"

@implementation RVButton
-(id)init:(CGSize)size :(CGPoint)position :(CGSize)labelSize :(NSString*)labelName :(NSString*)labelText {
    
    self = [RVButton spriteNodeWithColor:[SKColor whiteColor] size:labelSize];
    self.position = position;
    self.name = labelName;
    self.zPosition = 0.0;
    
    
    SKLabelNode *buttonLabel = [SKLabelNode labelNodeWithFontNamed:@"AppleSDGothicNeo-Bold"];
    buttonLabel.fontColor = [SKColor blackColor];
    buttonLabel.fontSize = 15;
    buttonLabel.text = labelText;
    buttonLabel.position = CGPointMake(0,0-5);
    buttonLabel.zPosition = 1.0;
    buttonLabel.name = self.name; //todo is this ok?
    

    
    
    [self addChild:buttonLabel];
    
    
    return self;
}
@end
