//
//  LSApplicationWorkspace.h
//  Comet
//
//  Created by Noah Little on 9/4/2023.
//

#ifndef LSApplicationWorkspace_h
#define LSApplicationWorkspace_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface _LSApplicationRecord : NSObject
@property (readonly) NSArray<NSString *> * appTags;
@property (getter=isLaunchProhibited,readonly) BOOL launchProhibited;
@end

@interface _LSApplicationProxy : NSObject
@property (nonatomic,readonly) NSString * applicationIdentifier;
@property (nonatomic,readonly) _LSApplicationRecord * correspondingApplicationRecord;
@property (nonatomic,readonly) NSString * applicationType;
@property (nonatomic,readonly) NSString * localizedName;
@end

@interface _LSApplicationWorkspace : NSObject
+ (nullable NSArray<_LSApplicationProxy *> *)allApplications;
@end
NS_ASSUME_NONNULL_END

#endif /* LSApplicationWorkspace_h */
