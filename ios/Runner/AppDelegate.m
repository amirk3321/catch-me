#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

[GeneratedPluginRegistrant registerWithRegistry:self];
[GMSServices provideAPIKey:@"AIzaSyDDqjP9EknjwoCICN4OHGE0UcDb3q_3y3Q"];

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
