 <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
    <!-- @formatter:off -->

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/IOS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>

    <xsl:template name="pushObjC">
      <folder  hideContent="true"    name="{$applicationName}-Push">
        <file  hideContent="true"    path="backendless-codegen/ObjC/Push/README.txt"/>
          
        <file name="Podfile">
target '<xsl:value-of select="$applicationName"/>-Push' do

use_frameworks!
pod 'BackendlessSwift'

end
        </file>
        
        <folder  hideContent="true" name="{$applicationName}-Push">
          <folder  hideContent="true" path="backendless-codegen/ObjC/Push/Push/Base.lproj"/>
          <folder  hideContent="true" path="backendless-codegen/ObjC/Push/Push/Assets.xcassets"/>
          <file  hideContent="true" path="backendless-codegen/ObjC/Push/Push/AppDelegate.h"/>
          <file  hideContent="true" path="backendless-codegen/ObjC/Push/Push/ViewController.h"/>
          <file  hideContent="true" path="backendless-codegen/ObjC/Push/Push/ViewController.m"/>
          <file  hideContent="true" path="backendless-codegen/ObjC/Push/Push/Info.plist"/>
          <file  hideContent="true" path="backendless-codegen/ObjC/Push/Push/main.m"/>
          
          <file  hideContent="true" name="AppDelegate.m">
#import "AppDelegate.h"
#import &lt;Backendless/Backendless-Swift.h&gt;

#define APPLICATION_ID @"<xsl:value-of select="$applicationId"/>"
#define API_KEY @"<xsl:value-of select="$apiKey"/>"
#define SERVER_URL @"<xsl:value-of select="$serverURL"/>"

@implementation AppDelegate

- (void)initBackendless {
    Backendless.shared.hostUrl = SERVER_URL;
    [Backendless.shared initAppWithApplicationId:APPLICATION_ID apiKey:API_KEY];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initBackendless];
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    });
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    [Backendless.shared.messaging registerDeviceWithDeviceToken:deviceToken responseHandler:^(NSString *registrationId) {
        [self showAlertWithTitle:@"Device registration completed" message:[NSString stringWithFormat:@"Check the registered device in the Backendless Console: Messaging > Devices > iOS. DeviceId: %@", Backendless.shared.messaging.currentDevice.deviceId] buttonTitle:@"OK"];
    } errorHandler:^(Fault *fault) {
        [self showAlertWithTitle:@"Device registration failed" message:fault.message buttonTitle:@"Dismiss"];
    }];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [self showAlertWithTitle:@"Device registration failed" message:error.localizedDescription buttonTitle:@"Dismiss"];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [self showAlertWithTitle:@"Push notification demo" message:@"You tapped a notification" buttonTitle:@"OK"];
    completionHandler(UIBackgroundFetchResultNewData);    
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle {
    UIAlertController *alert =  [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:nil]];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
          </file>   
          
          <file  hideContent="true" name="{$applicationName}-Push.entitlements">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"&gt;
&lt;plist version="1.0"&gt;
&lt;dict&gt;
	&lt;key&gt;aps-environment&lt;/key&gt;
	&lt;string&gt;development&lt;/string&gt;
&lt;/dict&gt;
&lt;/plist&gt;
          </file>
        </folder>
        
        <folder  hideContent="true"  name="{$applicationName}-Push.xcodeproj">
          <file  hideContent="true"    name="project.pbxproj">// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 46;
	objects = {

/* Begin PBXBuildFile section */
		5A5E5DF71EF80540001379FE /* main.m in Sources */ = {isa = PBXBuildFile; fileRef = 5A5E5DF61EF80540001379FE /* main.m */; };
		5A5E5DFA1EF80540001379FE /* AppDelegate.m in Sources */ = {isa = PBXBuildFile; fileRef = 5A5E5DF91EF80540001379FE /* AppDelegate.m */; };
		5A5E5DFD1EF80540001379FE /* ViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5A5E5DFC1EF80540001379FE /* ViewController.m */; };
		5A5E5E001EF80540001379FE /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5A5E5DFE1EF80540001379FE /* Main.storyboard */; };
		5A5E5E021EF80540001379FE /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 5A5E5E011EF80540001379FE /* Assets.xcassets */; };
		5A5E5E051EF80540001379FE /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5A5E5E031EF80540001379FE /* LaunchScreen.storyboard */; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		5A5E5DF21EF80540001379FE /* <xsl:value-of select="$applicationName"/>-Push.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "<xsl:value-of select="$applicationName"/>-Push.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		5A5E5DF61EF80540001379FE /* main.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = main.m; sourceTree = "&lt;group&gt;"; };
		5A5E5DF81EF80540001379FE /* AppDelegate.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = AppDelegate.h; sourceTree = "&lt;group&gt;"; };
		5A5E5DF91EF80540001379FE /* AppDelegate.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = AppDelegate.m; sourceTree = "&lt;group&gt;"; };
		5A5E5DFB1EF80540001379FE /* ViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = ViewController.h; sourceTree = "&lt;group&gt;"; };
		5A5E5DFC1EF80540001379FE /* ViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = ViewController.m; sourceTree = "&lt;group&gt;"; };
		5A5E5DFF1EF80540001379FE /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "&lt;group&gt;"; };
		5A5E5E011EF80540001379FE /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
		5A5E5E041EF80540001379FE /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
		5A5E5E061EF80540001379FE /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
		5A5E5E0C1EF80717001379FE /* <xsl:value-of select="$applicationName"/>-Push.entitlements */ = {isa = PBXFileReference; lastKnownFileType = text.plist.entitlements; path = "<xsl:value-of select="$applicationName"/>-Push.entitlements"; sourceTree = "&lt;group&gt;"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		5A5E5DEF1EF80540001379FE /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		5A5E5DE91EF80540001379FE = {
			isa = PBXGroup;
			children = (
				5A5E5DF41EF80540001379FE /* <xsl:value-of select="$applicationName"/>-Push */,
				5A5E5DF31EF80540001379FE /* Products */,
			);
			sourceTree = "&lt;group&gt;";
		};
		5A5E5DF31EF80540001379FE /* Products */ = {
			isa = PBXGroup;
			children = (
				5A5E5DF21EF80540001379FE /* <xsl:value-of select="$applicationName"/>-Push.app */,
			);
			name = Products;
			sourceTree = "&lt;group&gt;";
		};
		5A5E5DF41EF80540001379FE /* <xsl:value-of select="$applicationName"/>-Push */ = {
			isa = PBXGroup;
			children = (
				5A5E5E0C1EF80717001379FE /* <xsl:value-of select="$applicationName"/>-Push.entitlements */,
				5A5E5DF81EF80540001379FE /* AppDelegate.h */,
				5A5E5DF91EF80540001379FE /* AppDelegate.m */,
				5A5E5DFB1EF80540001379FE /* ViewController.h */,
				5A5E5DFC1EF80540001379FE /* ViewController.m */,
				5A5E5DFE1EF80540001379FE /* Main.storyboard */,
				5A5E5E011EF80540001379FE /* Assets.xcassets */,
				5A5E5E031EF80540001379FE /* LaunchScreen.storyboard */,
				5A5E5E061EF80540001379FE /* Info.plist */,
				5A5E5DF51EF80540001379FE /* Supporting Files */,
			);
			path = "<xsl:value-of select="$applicationName"/>-Push";
			sourceTree = "&lt;group&gt;";
		};
		5A5E5DF51EF80540001379FE /* Supporting Files */ = {
			isa = PBXGroup;
			children = (
				5A5E5DF61EF80540001379FE /* main.m */,
			);
			name = "Supporting Files";
			sourceTree = "&lt;group&gt;";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		5A5E5DF11EF80540001379FE /* <xsl:value-of select="$applicationName"/>-Push */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 5A5E5E091EF80540001379FE /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Push" */;
			buildPhases = (
				5A5E5DEE1EF80540001379FE /* Sources */,
				5A5E5DEF1EF80540001379FE /* Frameworks */,
				5A5E5DF01EF80540001379FE /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = "<xsl:value-of select="$applicationName"/>-Push";
			productName = "<xsl:value-of select="$applicationName"/>-Push";
			productReference = 5A5E5DF21EF80540001379FE /* <xsl:value-of select="$applicationName"/>-Push.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		5A5E5DEA1EF80540001379FE /* Project object */ = {
			isa = PBXProject;
			attributes = {
				LastUpgradeCheck = 1020;
				TargetAttributes = {
					5A5E5DF11EF80540001379FE = {
						CreatedOnToolsVersion = 8.3.2;
						ProvisioningStyle = Automatic;
						SystemCapabilities = {
							com.apple.BackgroundModes = {
								enabled = 1;
							};
							com.apple.Push = {
								enabled = 1;
							};
							com.apple.WAC = {
								enabled = 0;
							};
						};
					};
				};
			};
			buildConfigurationList = 5A5E5DED1EF80540001379FE /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Push" */;
			compatibilityVersion = "Xcode 3.2";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = 5A5E5DE91EF80540001379FE;
			productRefGroup = 5A5E5DF31EF80540001379FE /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				5A5E5DF11EF80540001379FE /* <xsl:value-of select="$applicationName"/>-Push */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		5A5E5DF01EF80540001379FE /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5A5E5E051EF80540001379FE /* LaunchScreen.storyboard in Resources */,
				5A5E5E021EF80540001379FE /* Assets.xcassets in Resources */,
				5A5E5E001EF80540001379FE /* Main.storyboard in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		5A5E5DEE1EF80540001379FE /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5A5E5DFD1EF80540001379FE /* ViewController.m in Sources */,
				5A5E5DFA1EF80540001379FE /* AppDelegate.m in Sources */,
				5A5E5DF71EF80540001379FE /* main.m in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXVariantGroup section */
		5A5E5DFE1EF80540001379FE /* Main.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5A5E5DFF1EF80540001379FE /* Base */,
			);
			name = Main.storyboard;
			sourceTree = "&lt;group&gt;";
		};
		5A5E5E031EF80540001379FE /* LaunchScreen.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5A5E5E041EF80540001379FE /* Base */,
			);
			name = LaunchScreen.storyboard;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
		5A5E5E071EF80540001379FE /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++0x";
				CLANG_CXX_LIBRARY = "libc++";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				GCC_C_LANGUAGE_STANDARD = gnu99;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				MTL_ENABLE_DEBUG_INFO = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		5A5E5E081EF80540001379FE /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++0x";
				CLANG_CXX_LIBRARY = "libc++";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				GCC_C_LANGUAGE_STANDARD = gnu99;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				MTL_ENABLE_DEBUG_INFO = NO;
				SDKROOT = iphoneos;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		5A5E5E0A1EF80540001379FE /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CODE_SIGN_ENTITLEMENTS = "<xsl:value-of select="$applicationName"/>-Push/<xsl:value-of select="$applicationName"/>-Push.entitlements";
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Push/Info.plist";
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				LIBRARY_SEARCH_PATHS = "$(inherited)";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Push";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 5.0;
			};
			name = Debug;
		};
		5A5E5E0B1EF80540001379FE /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CODE_SIGN_ENTITLEMENTS = "<xsl:value-of select="$applicationName"/>-Push/<xsl:value-of select="$applicationName"/>-Push.entitlements";
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Push/Info.plist";
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				LIBRARY_SEARCH_PATHS = "$(inherited)";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Push";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 5.0;
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		5A5E5DED1EF80540001379FE /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Push" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5A5E5E071EF80540001379FE /* Debug */,
				5A5E5E081EF80540001379FE /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		5A5E5E091EF80540001379FE /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Push" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5A5E5E0A1EF80540001379FE /* Debug */,
				5A5E5E0B1EF80540001379FE /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = 5A5E5DEA1EF80540001379FE /* Project object */;
}
          </file>
        </folder>
      </folder>
    </xsl:template>
</xsl:stylesheet>