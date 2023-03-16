#import "AppDelegate.h"
#import <React/RCTBundleURLProvider.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.moduleName = @"ReactNativeKountDemo";
    // You can add your custom initial props in the dictionary below.
    // They will be passed down to the ViewController used by React Native.
    self.initialProps = @{};
    
    // Configure and collect data using the Kount SDK
    NSString *sessionID = @"2089899661";
    [[KDataCollector sharedCollector] setDebug:YES];
    [[KDataCollector sharedCollector] setMerchantID:900100];
    [[KDataCollector sharedCollector] setLocationCollectorConfig:KLocationCollectorConfigRequestPermission];
    [[KDataCollector sharedCollector] setEnvironment:KEnvironmentTest];
    [[KountAnalyticsViewController sharedInstance] setEnvironmentForAnalytics:[KDataCollector sharedCollector].environment];
    bool analyticsData = YES;
    [[KountAnalyticsViewController sharedInstance] collect:sessionID analyticsSwitch:analyticsData completion:^(NSString * _Nonnull sessionID, bool success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"Collection Successful");
        }
        else {
            if (error != nil) {
                NSLog(@"Collection failed with error:%@", error.description);
            }
            else {
                NSLog(@"Collection failed without error");
            }
        }
    }];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
    return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
    return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end


