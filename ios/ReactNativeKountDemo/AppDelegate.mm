#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"ReactNativeKountDemo";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};
  
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

/// This method controls whether the `concurrentRoot`feature of React18 is turned on or off.
///
/// @see: https://reactjs.org/blog/2022/03/29/react-v18.html
/// @note: This requires to be rendering on Fabric (i.e. on the New Architecture).
/// @return: `true` if the `concurrentRoot` feature is enabled. Otherwise, it returns `false`.
- (BOOL)concurrentRootEnabled
{
  return true;
}

//function added manually per https://developer.kount.com/hc/en-us/articles/4411084422420 for iOS 12
- (void)applicationDidEnterBackground:(UIApplication *)application {
    KountAnalyticsViewController *backgroundTaskObject = [[KountAnalyticsViewController alloc] init];
    [backgroundTaskObject registerBackgroundTask];
}



NSString *sessionID = nil;


[[KDataCollector sharedCollector] setDebug:YES];

// Set your Merchant ID

[[KDataCollector sharedCollector] setMerchantID:99999];
// Set the location collection configuration
[[KDataCollector sharedCollector] setLocationCollectorConfig:KLocationCollectorConfigRequestPermission];
// For a released app, you'll want to set this to KEnvironmentProduction
[[KDataCollector sharedCollector] setEnvironment:KEnvironmentTest];
[[KountAnalyticsViewController sharedInstance] setEnvironmentForAnalytics: [KDataCollector.sharedCollector environment]];
//To collect Analytics Data, set Boolean flag - analyticsData to YES.
BOOL analyticsData = YES;
[[KountAnalyticsViewController sharedInstance] collect:sessionID analyticsSwitch:analyticsData completion:^(NSString * _Nonnull sessionID, _Bool success, NSError * _Nullable error) {
  //Completion block to know whether device data collection is successful/failed with error/failed without error.
  if (success) {
    NSLog(@"Collection Successful");
  }
  else {
    if(error != nil) {
      NSLog(@"Collection failed with error:%@",error.description);
    }
    else {
      NSLog(@"Collection failed without error");
    }
  }
}];


@end
