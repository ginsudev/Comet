//
//  _LSApplicationWorkspace.m
//  Comet
//
//  Created by Noah Little on 8/6/2025.
//

#import <Foundation/Foundation.h>
#import "LSApplicationWorkspace.h"
#import <MobileCoreServices/MobileCoreServices.h>

NS_ASSUME_NONNULL_BEGIN
@interface LSApplicationRecord : NSObject
@property (readonly) NSArray<NSString *> * appTags;
@property (getter=isLaunchProhibited,readonly) BOOL launchProhibited;
@end

@interface LSResourceProxy: NSObject
@property (setter=_setLocalizedName:,nonatomic,copy) NSString * localizedName;
@end

@interface LSApplicationProxy : LSResourceProxy
@property (nonatomic,readonly) NSString * applicationIdentifier;
@property (nonatomic,readonly) LSApplicationRecord * correspondingApplicationRecord;
@property (nonatomic,readonly) NSString * applicationType;
@end

@interface LSApplicationWorkspace : NSObject
+ (instancetype)defaultWorkspace;
- (nullable NSArray<LSApplicationProxy *> *)allApplications;
@end

@interface _LSApplicationProxy (Private)
- (instancetype)initWithLSApplicationProxy:(LSApplicationProxy *)proxy;
@end

@interface _LSApplicationRecord (Private)
- (instancetype)initWithLSApplicationRecord:(LSApplicationRecord *)record;
@end

NS_ASSUME_NONNULL_END

@implementation _LSApplicationWorkspace

+ (nullable NSArray<_LSApplicationProxy *> *)allApplications {
    LSApplicationWorkspace* workspace = [LSApplicationWorkspace defaultWorkspace];
    NSArray<LSApplicationProxy *> *workspaceApplications = workspace.allApplications;
    
    NSMutableArray<_LSApplicationProxy *> *applications = [[NSMutableArray alloc] init];
    for (int i = 0; i < workspaceApplications.count; i++) {
        LSApplicationProxy *applicationProxy = [workspaceApplications objectAtIndex:i];
        _LSApplicationProxy *mappedProxy = [[_LSApplicationProxy alloc] initWithLSApplicationProxy:applicationProxy];
        [applications addObject:mappedProxy];
    }
    
    return applications;
}

@end

@implementation _LSApplicationProxy

- (instancetype)initWithLSApplicationProxy:(LSApplicationProxy *)proxy {
    if (self = [super init]) {
        _applicationIdentifier = proxy.applicationIdentifier;
        _localizedName = proxy.localizedName;
        _applicationType = proxy.applicationType;
        _correspondingApplicationRecord = [[_LSApplicationRecord alloc] initWithLSApplicationRecord:proxy.correspondingApplicationRecord];
    }
    return self;
}

@end

@implementation _LSApplicationRecord

- (instancetype)initWithLSApplicationRecord:(LSApplicationRecord *)record {
    if (self = [super init]) {
        _appTags = record.appTags;
        _launchProhibited = record.launchProhibited;
    }
    return self;
}

@end
