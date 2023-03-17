#import "AppDelegate.h"
#import <React/RCTBundleURLProvider.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //// Configure the Data Collector
    
    NSString *sessionID = @"123456";
    [[KDataCollector sharedCollector] setDebug:YES];
    // TODO Set your Merchant ID
    [[KDataCollector sharedCollector] setMerchantID:99999];
    // TODO Set the location collection configuration
    [[KDataCollector sharedCollector] setLocationCollectorConfig:KLocationCollectorConfigRequestPermission];
    // For a released app, you'll want to set this to KEnvironmentProduction
    [[KDataCollector sharedCollector] setEnvironment:KEnvironmentTest];
    KountAnalyticsViewController *dataCollectionObject = [[KountAnalyticsViewController alloc] init];
    [dataCollectionObject setEnvironmentForAnalytics: [KDataCollector.sharedCollector environment]];
    // To collect Analytics Data, you'll want set this analyticsData to YES or else NO
    BOOL analyticsData = YES;
    [dataCollectionObject collect:sessionID analyticsSwitch:analyticsData completion:^(NSString * _Nonnull sessionID, BOOL success, NSError * _Nullable error) {
        if(success) {
            NSLog(@"Collection Successful");
        }
        else {
            if (error != nil) {
                NSLog(@"Collection failed with error:%@",error.description);
            }
            else {
                NSLog(@"Collection failed without error");
            }
        }
    }];
    
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  NSLog(@"Enter applicationDidEnterBackground");
    if(@available(*, iOS 12.4.7)) {
      NSLog(@"Calling KountAnalyticsViewController");
        KountAnalyticsViewController *backgroundTaskObject = [[KountAnalyticsViewController alloc] init];
        [backgroundTaskObject registerBackgroundTask];
    }
}

@end
