#import <SpriteKit/SpriteKit.h>

@interface RVBlocks : SKSpriteNode
@property bool isSmall;
-(id)init:(CGSize)size :(bool)isSmall;
-(id)setNewPositionAndRunAction:(int)positionAdd :(SKAction*)action :(CGSize)sSize :(bool)setMultipleLayer :(RVBlocks *)lastObject :(int)newLayerY :(bool)isSmall;
@end
