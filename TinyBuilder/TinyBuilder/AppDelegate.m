//
//  AppDelegate.m
//  TinyBuilder
//
//  Created by xiangfp on 15/4/16.
//  Copyright (c) 2015年 Sunline. All rights reserved.
//

#import "AppDelegate.h"
#import "Configuration.h"
#import <CoreText/CoreText.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self registerDefaultsFromSettingsBundle];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    CGFloat top = [Configuration configuration].topOffset;
    CGRect frame = {{0, top}, {self.window.frame.size.width, self.window.frame.size.height - top}};
    
    TinyViewController *tbViewController = [[TinyViewController alloc] initWithTinyViewFrame:frame];
    [tbViewController connect];
//
    self.window.rootViewController = tbViewController;
    [self.window makeKeyAndVisible];

    // Override point for customization after application launch.
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
//    [self.tinyView openWindowWithURL:@"file:///test.html" width:@"100%" height:@"100%"];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - systemSettings
- (void)registerDefaultsFromSettingsBundle {
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    // NSLog(@"settings:%@",settings);
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            id value=[prefSpecification objectForKey:@"DefaultValue"];
            
            [defaultsToRegister setObject:value forKey:key];
        }
    }
    
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}



@end
