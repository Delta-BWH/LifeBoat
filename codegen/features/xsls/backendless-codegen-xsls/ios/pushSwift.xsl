 <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
    <!-- @formatter:off -->

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/IOS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>

    <xsl:template name="pushSwift">
      <folder  hideContent="true"    name="{$applicationName}-Push">
        <file  hideContent="true"    path="backendless-codegen/Swift/Push/README.txt"/>
          
        <file name="Podfile">

target '<xsl:value-of select="$applicationName"/>-Push' do

use_frameworks!
pod 'BackendlessSwift'

end
        </file>
        
        <folder  hideContent="true" name="{$applicationName}-Push">
          <folder  hideContent="true" path="backendless-codegen/Swift/Push/Push/Base.lproj"/>
          <folder  hideContent="true" path="backendless-codegen/Swift/Push/Push/Assets.xcassets"/>
          <file  hideContent="true" path="backendless-codegen/Swift/Push/Push/ViewController.swift"/>
          <file  hideContent="true" path="backendless-codegen/Swift/Push/Push/Info.plist"/>
          
          <file  hideContent="true" name="AppDelegate.swift">

import UIKit
import UserNotifications
import Backendless

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    private let APPLICATION_ID = "<xsl:value-of select="$applicationId"/>"
    private let API_KEY = "<xsl:value-of select="$apiKey"/>"
    private let SERVER_URL = "<xsl:value-of select="$serverURL"/>"
    
    var window: UIWindow?
    
    private func initBackendless() {
        Backendless.shared.hostUrl = SERVER_URL
        Backendless.shared.initApp(applicationId: APPLICATION_ID, apiKey: API_KEY)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initBackendless()
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }            
        }
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Backendless.shared.messaging.registerDevice(deviceToken: deviceToken, responseHandler: { registrationId in
            self.showAlert(title: "Device registration completed", message: "Check the registered device in the Backendless Console: Messaging > Devices > iOS. DeviceId: \(Backendless.shared.messaging.currentDevice().deviceId ?? "")", buttonTitle: "OK")
        }, errorHandler: { fault in
            self.showAlert(title: "Device registration failed", message: fault.message ?? "", buttonTitle: "Dismiss")
        })
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        showAlert(title: "Device registration failed", message: error.localizedDescription, buttonTitle: "Dismiss")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        showAlert(title: "Push notification demo", message: "You tapped a notification", buttonTitle: "OK")
        completionHandler(.newData)
    }
    
    private func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)

    }
}  
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
		5A37A8241F18E662002A7625 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5A37A8231F18E662002A7625 /* AppDelegate.swift */; };
		5A37A8261F18E662002A7625 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5A37A8251F18E662002A7625 /* ViewController.swift */; };
		5A37A8291F18E662002A7625 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5A37A8271F18E662002A7625 /* Main.storyboard */; };
		5A37A82B1F18E662002A7625 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 5A37A82A1F18E662002A7625 /* Assets.xcassets */; };
		5A37A83E1F18E6F6002A7625 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5A37A83C1F18E6F6002A7625 /* LaunchScreen.storyboard */; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		5A37A8201F18E662002A7625 /* <xsl:value-of select="$applicationName"/>-Push.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "<xsl:value-of select="$applicationName"/>-Push.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		5A37A8231F18E662002A7625 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "&lt;group&gt;"; };
		5A37A8251F18E662002A7625 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "&lt;group&gt;"; };
		5A37A8281F18E662002A7625 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "&lt;group&gt;"; };
		5A37A82A1F18E662002A7625 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
		5A37A82F1F18E662002A7625 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
		5A37A83D1F18E6F6002A7625 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
		5AF692901F18E7F200785B73 /* <xsl:value-of select="$applicationName"/>-Push.entitlements */ = {isa = PBXFileReference; lastKnownFileType = text.plist.entitlements; path = "<xsl:value-of select="$applicationName"/>-Push.entitlements"; sourceTree = "&lt;group&gt;"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		5A37A81D1F18E662002A7625 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		5A37A8171F18E662002A7625 = {
			isa = PBXGroup;
			children = (
				5A37A8221F18E662002A7625 /* <xsl:value-of select="$applicationName"/>-Push */,
				5A37A8211F18E662002A7625 /* Products */,
			);
			sourceTree = "&lt;group&gt;";
		};
		5A37A8211F18E662002A7625 /* Products */ = {
			isa = PBXGroup;
			children = (
				5A37A8201F18E662002A7625 /* <xsl:value-of select="$applicationName"/>-Push.app */,
			);
			name = Products;
			sourceTree = "&lt;group&gt;";
		};
		5A37A8221F18E662002A7625 /* <xsl:value-of select="$applicationName"/>-Push */ = {
			isa = PBXGroup;
			children = (
				5AF692901F18E7F200785B73 /* <xsl:value-of select="$applicationName"/>-Push.entitlements */,
				5A37A83C1F18E6F6002A7625 /* LaunchScreen.storyboard */,
				5A37A8231F18E662002A7625 /* AppDelegate.swift */,
				5A37A8251F18E662002A7625 /* ViewController.swift */,
				5A37A8271F18E662002A7625 /* Main.storyboard */,
				5A37A82A1F18E662002A7625 /* Assets.xcassets */,
				5A37A82F1F18E662002A7625 /* Info.plist */,
			);
			path = "<xsl:value-of select="$applicationName"/>-Push";
			sourceTree = "&lt;group&gt;";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		5A37A81F1F18E662002A7625 /* <xsl:value-of select="$applicationName"/>-Push */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 5A37A8321F18E662002A7625 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Push" */;
			buildPhases = (
				5A37A81C1F18E662002A7625 /* Sources */,
				5A37A81D1F18E662002A7625 /* Frameworks */,
				5A37A81E1F18E662002A7625 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = "<xsl:value-of select="$applicationName"/>-Push";
			productName = "<xsl:value-of select="$applicationName"/>-Push";
			productReference = 5A37A8201F18E662002A7625 /* <xsl:value-of select="$applicationName"/>-Push.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		5A37A8181F18E662002A7625 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				LastSwiftUpdateCheck = 0830;
				LastUpgradeCheck = 1020;
				TargetAttributes = {
					5A37A81F1F18E662002A7625 = {
						CreatedOnToolsVersion = 8.3.2;
						LastSwiftMigration = 1020;
						ProvisioningStyle = Automatic;
						SystemCapabilities = {
							com.apple.BackgroundModes = {
								enabled = 1;
							};
							com.apple.Push = {
								enabled = 1;
							};
						};
					};
				};
			};
			buildConfigurationList = 5A37A81B1F18E662002A7625 /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Push" */;
			compatibilityVersion = "Xcode 3.2";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = 5A37A8171F18E662002A7625;
			productRefGroup = 5A37A8211F18E662002A7625 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				5A37A81F1F18E662002A7625 /* <xsl:value-of select="$applicationName"/>-Push */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		5A37A81E1F18E662002A7625 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5A37A83E1F18E6F6002A7625 /* LaunchScreen.storyboard in Resources */,
				5A37A82B1F18E662002A7625 /* Assets.xcassets in Resources */,
				5A37A8291F18E662002A7625 /* Main.storyboard in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		5A37A81C1F18E662002A7625 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5A37A8261F18E662002A7625 /* ViewController.swift in Sources */,
				5A37A8241F18E662002A7625 /* AppDelegate.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXVariantGroup section */
		5A37A8271F18E662002A7625 /* Main.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5A37A8281F18E662002A7625 /* Base */,
			);
			name = Main.storyboard;
			sourceTree = "&lt;group&gt;";
		};
		5A37A83C1F18E6F6002A7625 /* LaunchScreen.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5A37A83D1F18E6F6002A7625 /* Base */,
			);
			name = LaunchScreen.storyboard;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
		5A37A8301F18E662002A7625 /* Debug */ = {
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
				IPHONEOS_DEPLOYMENT_TARGET = 10.3;
				MTL_ENABLE_DEBUG_INFO = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		5A37A8311F18E662002A7625 /* Release */ = {
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
				IPHONEOS_DEPLOYMENT_TARGET = 10.3;
				MTL_ENABLE_DEBUG_INFO = NO;
				SDKROOT = iphoneos;
				SWIFT_OPTIMIZATION_LEVEL = "-Owholemodule";
				TARGETED_DEVICE_FAMILY = "1,2";
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		5A37A8331F18E662002A7625 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CODE_SIGN_ENTITLEMENTS = "<xsl:value-of select="$applicationName"/>-Push/<xsl:value-of select="$applicationName"/>-Push.entitlements";
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Push/Info.plist";
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				LIBRARY_SEARCH_PATHS = "$(inherited)";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Push";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_OBJC_BRIDGING_HEADER = "";
				SWIFT_VERSION = 5.0;
			};
			name = Debug;
		};
		5A37A8341F18E662002A7625 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CODE_SIGN_ENTITLEMENTS = "<xsl:value-of select="$applicationName"/>-Push/<xsl:value-of select="$applicationName"/>-Push.entitlements";
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Push/Info.plist";
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				LIBRARY_SEARCH_PATHS = "$(inherited)";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Push";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_OBJC_BRIDGING_HEADER = "";
				SWIFT_VERSION = 5.0;
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		5A37A81B1F18E662002A7625 /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Push" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5A37A8301F18E662002A7625 /* Debug */,
				5A37A8311F18E662002A7625 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		5A37A8321F18E662002A7625 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Push" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5A37A8331F18E662002A7625 /* Debug */,
				5A37A8341F18E662002A7625 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = 5A37A8181F18E662002A7625 /* Project object */;
}
          </file>
        </folder>
      </folder>
    </xsl:template>
</xsl:stylesheet>