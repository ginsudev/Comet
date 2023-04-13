//
//  CMApplicationWorkspace.m
//  Comet
//
//  Created by Noah Little on 9/4/2023.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "LSApplicationWorkspace.h"
#import "CMApplicationWorkspace.h"

@implementation CMApplicationWorkspace

- (LSApplicationWorkspace *)underlyingWorkspace {
    LSApplicationWorkspace *workspace = [objc_getClass("LSApplicationWorkspace") defaultWorkspace];
    return workspace;
}

- (NSArray<NSDictionary *> *)allApplications {
    NSArray<LSApplicationProxy *> *proxies = [[self underlyingWorkspace] allInstalledApplications];
    NSMutableArray<NSDictionary *> *appDictionaryRepresentations = [[NSMutableArray alloc] init];
    
    for (LSApplicationProxy *proxy in proxies) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        if (![self isHiddenProxy:proxy]) {
            BOOL isSystem = [proxy.applicationType isEqual:@"System"];
            [dict setValue:proxy.applicationIdentifier forKey:@"identifier"];
            [dict setValue:proxy.localizedName forKey:@"displayName"];
            [dict setValue:[NSNumber numberWithBool:isSystem] forKey:@"isSystem"];
            [appDictionaryRepresentations addObject:dict];
        }
    }
    
    return appDictionaryRepresentations;
}

- (UIImage *)iconForBundleIdentifier:(NSString *)bundleIdentifier {
    LSApplicationProxy *proxy = [objc_getClass("LSApplicationProxy") applicationProxyForIdentifier:bundleIdentifier];
    return [proxy appIconForTableCell];
}

- (BOOL)isHiddenProxy:(LSApplicationProxy *)proxy {
    // Thanks to @opa334dev for his research here.
    LSApplicationRecord *record = proxy.correspondingApplicationRecord;
    BOOL isWebApplication = ([proxy.applicationIdentifier rangeOfString:@"com.apple.webapp" options:NSCaseInsensitiveSearch].location != NSNotFound);
    BOOL isHidden = [record.appTags containsObject:@"hidden"];
    return (isWebApplication || isHidden || record.launchProhibited);
}

@end
