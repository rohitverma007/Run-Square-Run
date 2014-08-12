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
