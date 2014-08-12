#import <SpriteKit/SpriteKit.h>

BOOL lololol;
@interface RVPlatform : SKSpriteNode
-(id)init:(CGSize)size;
-(void) createFirstPlatform;
-(RVPlatform*) createNewPlatform;
-(id)setNewPosition:(CGPoint)position;
-(id)setNewPositionAndRunAction:(int)positionAdd :(SKAction*)action;
+(void)overrideAction:(SKAction*)action;
@property (readwrite)int prevPositionX;
@property (readwrite)int prevWidth;
@property (readwrite)int prevSpace;
@end
