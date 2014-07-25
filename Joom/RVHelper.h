//
//  RVHelper.h
//  Joom
//
//  Created by Rohit Verma on 2014-07-23.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RVPlatform.h"
#import "RVBlocks.h"
#import "RVAppDelegate.h"
@interface RVHelper : RVAppDelegate
+(int)getDistance:(RVPlatform*)prevPlatform;
+(int)generateRandNumber:(int)rType :(CGSize)size;
+(int)getSmallBlocksDistance:(RVBlocks *)prevBlock;
+(int)getBigBlocksDistance:(RVBlocks *)prevBlock;
@end
