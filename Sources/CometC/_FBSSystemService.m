//
//  _FBSSystemService.m
//  Comet
//
//  Created by Noah Little on 23/4/2023.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#include "FBSSystemService.h"

#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation _SBSRelaunchAction

+ (instancetype)actionWithReason:(NSString *)reason options:(SBSRelaunchActionOptions)options targetURL:(NSURL *)url {
    return [objc_getClass("SBSRelaunchAction") actionWithReason:reason options:options targetURL:url];
}

@end

@implementation _FBSSystemService

+ (instancetype)sharedService {
    return [objc_getClass("FBSSystemService") sharedService];
}

@end
