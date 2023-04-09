//
//  Respring-Private.h
//  Comet
//
//  Created by Noah Little on 9/4/2023.
//

#ifndef Respring_Private_h
#define Respring_Private_h

typedef NS_OPTIONS(NSUInteger, SBSRelaunchActionOptions) {
    SBSRelaunchActionOptionsNone,
    SBSRelaunchActionOptionsRestartRenderServer = 1 << 0,
    SBSRelaunchActionOptionsSnapshotTransition = 1 << 1,
    SBSRelaunchActionOptionsFadeToBlackTransition = 1 << 2
};

@interface SBSRelaunchAction : NSObject
+ (instancetype)actionWithReason:(id)arg1 options:(SBSRelaunchActionOptions)arg2 targetURL:(id)arg3;
@end

@interface FBSSystemService : NSObject
+ (instancetype)sharedService;
- (void)sendActions:(id)arg1 withResult:(/*^block*/id)arg2;
@end

#endif /* Respring_Private_h */
