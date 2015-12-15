

#import "AvoidRetainCycleBlockStorge.h"

@interface InternalStorgePool : NSObject
@property (nonatomic, retain) NSMutableDictionary* dict;
+ (InternalStorgePool *)sharedPool;
@end

@interface AvoidRetainCycleBlockStorge ()
@property (nonatomic, assign) id fastWeakCache;
@end

@implementation AvoidRetainCycleBlockStorge
- (void)dealloc
{
    [[InternalStorgePool sharedPool].dict removeObjectForKey:[NSValue valueWithNonretainedObject:self]];
}

- (void)setBlockAutoCopy:(id)block
{
    id blockCopy = [block copy];
    if (blockCopy) {
        [[InternalStorgePool sharedPool].dict setObject:blockCopy forKey:[NSValue valueWithNonretainedObject:self]];
    } else {
        [[InternalStorgePool sharedPool].dict removeObjectForKey:[NSValue valueWithNonretainedObject:self]];
    }
    self.fastWeakCache = blockCopy;
}

- (id)getBlockReference
{
    return self.fastWeakCache;
}

@end


@implementation InternalStorgePool

+ (InternalStorgePool *)sharedPool
{
    static InternalStorgePool* s_pool = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        s_pool = [[InternalStorgePool alloc] init];
    });
    return s_pool;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.dict = [NSMutableDictionary dictionary];
    }
    return self;
}


@end