//
//  AppDelegate.m
//  getAppBundle
//
//  Created by ian on 16/7/4.
//  Copyright © 2016年 ian. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/runtime.h>
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    NSArray *appList = [workspace performSelector:@selector(allApplications)];
    Class LSApplicationProxy_class = object_getClass(@"LSApplicationProxy");
    
    NSMutableDictionary *allDic = [@{} mutableCopy];
    
    for (LSApplicationProxy_class in appList)
    {
        NSString *bundleID = [LSApplicationProxy_class performSelector:@selector(applicationIdentifier)];
        NSString *version = [LSApplicationProxy_class performSelector:@selector(bundleVersion)];
        NSString *resourcesDirectoryURL = [LSApplicationProxy_class performSelector:@selector(resourcesDirectoryURL)];
        NSString *sdkVersion = [LSApplicationProxy_class performSelector:@selector(sdkVersion)];
        NSString *dataContainerURL = [LSApplicationProxy_class performSelector:@selector(dataContainerURL)];
        
        NSMutableDictionary *data = [@{} mutableCopy];
        data[@"bundleVersion"] = version;
        data[@"resourcesDirectoryURL"] = resourcesDirectoryURL;
        data[@"sdkVersion"] = sdkVersion;
        data[@"dataContainerURL"] = dataContainerURL;
        
        allDic[bundleID] = data;
        
    }
    
    NSLog(@"☺%@",allDic);
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController *viewController = [[ViewController alloc] init];
    viewController.text = [allDic description];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
