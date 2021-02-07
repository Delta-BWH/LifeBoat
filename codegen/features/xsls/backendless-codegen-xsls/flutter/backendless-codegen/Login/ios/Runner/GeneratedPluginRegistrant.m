//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <backendless_sdk/BackendlessSdkPlugin.h>
#import <flutter_twitter_login/TwitterLoginPlugin.h>
#import <google_sign_in/GoogleSignInPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [BackendlessSdkPlugin registerWithRegistrar:[registry registrarForPlugin:@"BackendlessSdkPlugin"]];
  [TwitterLoginPlugin registerWithRegistrar:[registry registrarForPlugin:@"TwitterLoginPlugin"]];
  [FLTGoogleSignInPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTGoogleSignInPlugin"]];
}

@end
