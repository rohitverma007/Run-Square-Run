//
//  RVHelper.m
//  Joom
//
//  Created by Rohit Verma on 2014-07-23.
//  Copyright (c) 2014 rohitv. All rights reserved.
//

#import "RVHelper.h"

@implementation RVHelper

+(int)generateRandNumber:(int)rType :(CGSize)size{
    //TODO Maybe seprate into different functions?
    int randNumber = 0;
    int min = 50;
    if(rType == 1){ //Width
        randNumber = arc4random_uniform(((int)size.width-100) - min) + 50;
    }
    if(rType == 2){ //Space
        randNumber = arc4random_uniform((int)size.width);
    }
    
    if(rType == 3){//Height
        randNumber = arc4random_uniform((int)size.height-100) - (int)(size.height/2-100);
        //        randNumber = arc4random() % (int)(size.height-100) - ((int)size.height/2+100);
    }
    
    if(rType == 4){
        int temp =  arc4random() % 40;
        
        if (temp % 2 == 0) {
            randNumber = 0;
        } else {
            randNumber = arc4random() % 40 + 15;
            
        }
    }
    
    
    return randNumber;
};

+(int)getDistance:(RVPlatform *)prevPlatform{

    return prevPlatform.position.x+prevPlatform.size.width/2+[self generateRandNumber:4 :prevPlatform.size];
}

+(int)getBlocksDistance:(RVBlocks *)prevBlock{
    return prevBlock.position.x+prevBlock.size.width/2+50;

}
@end
