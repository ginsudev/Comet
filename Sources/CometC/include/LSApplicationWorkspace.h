//
//  LSApplicationWorkspace.h
//  Comet
//
//  Created by Noah Little on 9/4/2023.
//

#ifndef LSApplicationWorkspace_h
#define LSApplicationWorkspace_h

#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

NS_ASSUME_NONNULL_BEGIN
@interface LSApplicationRecord : NSObject
@property (readonly) NSArray<NSString *> * appTags;
@property (getter=isLaunchProhibited,readonly) BOOL launchProhibited;
@end

@interface LSApplicationProxy (Private)
@property (nonatomic,readonly) LSApplicationRecord * correspondingApplicationRecord;
@property (nonatomic,readonly) NSString * applicationType;
@end

NS_ASSUME_NONNULL_END

#endif /* LSApplicationWorkspace_h */
