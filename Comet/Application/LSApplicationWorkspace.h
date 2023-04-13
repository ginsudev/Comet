//
//  LSApplicationWorkspace.h
//  Comet
//
//  Created by Noah Little on 9/4/2023.
//

#ifndef LSApplicationWorkspace_h
#define LSApplicationWorkspace_h

#import <UIKit/UIKit.h>

@interface LSApplicationRecord : NSObject
@property (readonly) NSArray * appTags;
@property (getter=isLaunchProhibited,readonly) BOOL launchProhibited;
@end

@interface LSResourceProxy: NSObject
@property (setter=_setLocalizedName:,nonatomic,copy) NSString * localizedName;
@end

@interface LSApplicationProxy : LSResourceProxy
@property (nonatomic,readonly) NSString * applicationIdentifier;
@property (nonatomic,readonly) LSApplicationRecord * correspondingApplicationRecord;
@property (nonatomic,readonly) NSString * applicationType;
+ (instancetype)applicationProxyForIdentifier:(NSString *)identifier;
- (UIImage *)appIconForTableCell;
@end

@interface LSApplicationWorkspace : NSObject
+ (instancetype)defaultWorkspace;
- (NSArray<LSApplicationProxy *> *)allInstalledApplications;
@end

#endif /* LSApplicationWorkspace_h */
