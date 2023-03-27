//
//  Respring.h
//  Comet
//
//  Created by Noah Little on 26/3/2023.
//

#ifndef Respring_h
#define Respring_h

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, SBSRelaunchActionOptions) {
    SBSRelaunchActionOptionsNone,
    SBSRelaunchActionOptionsRestartRenderServer = 1 << 0,
    SBSRelaunchActionOptionsSnapshotTransition = 1 << 1,
    SBSRelaunchActionOptionsFadeToBlackTransition = 1 << 2
};

#endif /* Respring_h */

@interface SBSRelaunchAction : NSObject
+ (instancetype)actionWithReason:(id)arg1 options:(SBSRelaunchActionOptions)arg2 targetURL:(id)arg3;
@end

@interface FBSSystemService : NSObject
+ (instancetype)sharedService;
- (void)sendActions:(id)arg1 withResult:(/*^block*/id)arg2;
@end

@interface Respring : NSObject
+ (void)execute;
@end
