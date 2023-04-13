//
//  CMApplicationWorkspace.h
//  Comet
//
//  Created by Noah Little on 9/4/2023.
//

#ifndef CMApplicationWorkspace_h
#define CMApplicationWorkspace_h

#import <UIKit/UIKit.h>

@protocol CMApplicationWorkspaceInterface
- (NSArray<NSDictionary *> *)allApplications;
- (UIImage *)iconForBundleIdentifier:(NSString *)bundleIdentifier;
@end

@interface CMApplicationWorkspace : NSObject <CMApplicationWorkspaceInterface>
- (NSArray<NSDictionary *> *)allApplications;
- (UIImage *)iconForBundleIdentifier:(NSString *)bundleIdentifier;
@end

#endif /* CMApplicationWorkspace_h */
