//
//  RVHelper.m
//  Joom
//
//  Created by Rohit Verma on 2014-07-23.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVHelper.h"

@implementation RVHelper
+(int)getDistance:(RVPlatform *)prevPlatform{
    return prevPlatform.position.x+prevPlatform.size.width/2+100;
}
@end
