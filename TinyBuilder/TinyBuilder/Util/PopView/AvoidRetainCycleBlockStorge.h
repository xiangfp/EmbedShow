


#import <Foundation/Foundation.h>

@interface AvoidRetainCycleBlockStorge : NSObject
- (void)setBlockAutoCopy:(id)block;
- (id)getBlockReference;
@end
