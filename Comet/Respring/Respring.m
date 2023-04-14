//
//  Respring.m
//  Comet
//
//  Created by Noah Little on 26/3/2023.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Respring.h"
#import "Respring-Private.h"

@implementation Respring

+ (void)execute {
    SBSRelaunchAction *action = [
        objc_getClass("SBSRelaunchAction")
        actionWithReason:@"RestartRenderServer"
        options:SBSRelaunchActionOptionsFadeToBlackTransition
        targetURL:nil
    ];
    
    FBSSystemService *service = [objc_getClass("FBSSystemService") sharedService];
    [service sendActions:[NSSet setWithObject:action] withResult:nil];
}

@end
