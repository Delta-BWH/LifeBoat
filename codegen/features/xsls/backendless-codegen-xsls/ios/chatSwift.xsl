 <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
    <!-- @formatter:off -->

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/IOS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>

    <xsl:template name="chatSwift">
    	<folder  hideContent="true"    name="{$applicationName}-Chat">
        	<file  hideContent="true"    path="backendless-codegen/Swift/Chat/README.txt"/>
          
        	<file name="Podfile">
target '<xsl:value-of select="$applicationName"/>-Chat' do

use_frameworks!
pod 'BackendlessSwift'

end
        	</file>
        
        	<folder  hideContent="true" name="{$applicationName}-Chat">
          		<folder  hideContent="true" path="backendless-codegen/Swift/Chat/Chat/Base.lproj"/>
          		<folder  hideContent="true" path="backendless-codegen/Swift/Chat/Chat/Assets.xcassets"/>
          		<file  hideContent="true" path="backendless-codegen/Swift/Chat/Chat/ViewController.swift"/>
         		  <file  hideContent="true" path="backendless-codegen/Swift/Chat/Chat/ChatViewController.swift"/>
          		<file  hideContent="true" path="backendless-codegen/Swift/Chat/Chat/Info.plist"/>
          
          		<file  hideContent="true" name="AppDelegate.swift">
import UIKit
import Backendless

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let APPLICATION_ID = "<xsl:value-of select="$applicationId"/>"
    private let API_KEY = "<xsl:value-of select="$apiKey"/>"
    private let SERVER_URL = "<xsl:value-of select="$serverURL"/>"

    var window: UIWindow?
    
    func initBackendless() {
        Backendless.shared.hostUrl = SERVER_URL
        Backendless.shared.initApp(applicationId: APPLICATION_ID, apiKey: API_KEY)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initBackendless()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        window?.endEditing(true)
    }
}
          		</file>   
        	</folder>
        
        	<folder  hideContent="true"  name="{$applicationName}-Chat.xcodeproj">
          		<file  hideContent="true" name="project.pbxproj">// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 51;
	objects = {

/* Begin PBXBuildFile section */
		5EC3801420B6D613003FFC46 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5EC3801320B6D613003FFC46 /* AppDelegate.swift */; };
		5EC3801620B6D613003FFC46 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5EC3801520B6D613003FFC46 /* ViewController.swift */; };
		5EC3801920B6D613003FFC46 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5EC3801720B6D613003FFC46 /* Main.storyboard */; };
		5EC3801B20B6D614003FFC46 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 5EC3801A20B6D614003FFC46 /* Assets.xcassets */; };
		5EC3801E20B6D614003FFC46 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5EC3801C20B6D614003FFC46 /* LaunchScreen.storyboard */; };
		5EC3812E20B6DA13003FFC46 /* ChatViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5EC3812D20B6DA13003FFC46 /* ChatViewController.swift */; };
/* End PBXBuildFile section */

/* Begin PBXCopyFilesBuildPhase section */
		5E06B9F2227C6E68000BBCAD /* Embed Frameworks */ = {
			isa = PBXCopyFilesBuildPhase;
			buildActionMask = 2147483647;
			dstPath = "";
			dstSubfolderSpec = 10;
			files = (
			);
			name = "Embed Frameworks";
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXCopyFilesBuildPhase section */

/* Begin PBXFileReference section */
		5EC3801020B6D613003FFC46 /* <xsl:value-of select="$applicationName"/>-Chat.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "<xsl:value-of select="$applicationName"/>-Chat.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		5EC3801320B6D613003FFC46 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "&lt;group&gt;"; };
		5EC3801520B6D613003FFC46 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "&lt;group&gt;"; };
		5EC3801820B6D613003FFC46 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "&lt;group&gt;"; };
		5EC3801A20B6D614003FFC46 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
		5EC3801D20B6D614003FFC46 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
		5EC3801F20B6D614003FFC46 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
		5EC3812D20B6DA13003FFC46 /* ChatViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ChatViewController.swift; sourceTree = "&lt;group&gt;"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		5EC3800D20B6D613003FFC46 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		5EC3800720B6D613003FFC46 = {
			isa = PBXGroup;
			children = (
				5EC3801220B6D613003FFC46 /* <xsl:value-of select="$applicationName"/>-Chat */,
				5EC3801120B6D613003FFC46 /* Products */,
			);
			sourceTree = "&lt;group&gt;";
		};
		5EC3801120B6D613003FFC46 /* Products */ = {
			isa = PBXGroup;
			children = (
				5EC3801020B6D613003FFC46 /* <xsl:value-of select="$applicationName"/>-Chat.app */,
			);
			name = Products;
			sourceTree = "&lt;group&gt;";
		};
		5EC3801220B6D613003FFC46 /* <xsl:value-of select="$applicationName"/>-Chat */ = {
			isa = PBXGroup;
			children = (
				5EC3801320B6D613003FFC46 /* AppDelegate.swift */,
				5EC3801520B6D613003FFC46 /* ViewController.swift */,
				5EC3812D20B6DA13003FFC46 /* ChatViewController.swift */,
				5EC3801F20B6D614003FFC46 /* Info.plist */,
				5EC3801720B6D613003FFC46 /* Main.storyboard */,
				5EC3801C20B6D614003FFC46 /* LaunchScreen.storyboard */,
				5EC3801A20B6D614003FFC46 /* Assets.xcassets */,
			);
			path = "<xsl:value-of select="$applicationName"/>-Chat";
			sourceTree = "&lt;group&gt;";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		5EC3800F20B6D613003FFC46 /* <xsl:value-of select="$applicationName"/>-Chat */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 5EC3802220B6D614003FFC46 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Chat" */;
			buildPhases = (
				5EC3800C20B6D613003FFC46 /* Sources */,
				5EC3800D20B6D613003FFC46 /* Frameworks */,
				5EC3800E20B6D613003FFC46 /* Resources */,
				5E06B9F2227C6E68000BBCAD /* Embed Frameworks */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = "<xsl:value-of select="$applicationName"/>-Chat";
			productName = "<xsl:value-of select="$applicationName"/>-Chat";
			productReference = 5EC3801020B6D613003FFC46 /* <xsl:value-of select="$applicationName"/>-Chat.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		5EC3800820B6D613003FFC46 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				LastSwiftUpdateCheck = 0930;
				LastUpgradeCheck = 0930;
				ORGANIZATIONNAME = Backendless;
				TargetAttributes = {
					5EC3800F20B6D613003FFC46 = {
						CreatedOnToolsVersion = 9.3.1;
						LastSwiftMigration = 1020;
					};
				};
			};
			buildConfigurationList = 5EC3800B20B6D613003FFC46 /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Chat" */;
			compatibilityVersion = "Xcode 9.3";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = 5EC3800720B6D613003FFC46;
			productRefGroup = 5EC3801120B6D613003FFC46 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				5EC3800F20B6D613003FFC46 /* <xsl:value-of select="$applicationName"/>-Chat */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		5EC3800E20B6D613003FFC46 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5EC3801E20B6D614003FFC46 /* LaunchScreen.storyboard in Resources */,
				5EC3801B20B6D614003FFC46 /* Assets.xcassets in Resources */,
				5EC3801920B6D613003FFC46 /* Main.storyboard in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		5EC3800C20B6D613003FFC46 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5EC3801620B6D613003FFC46 /* ViewController.swift in Sources */,
				5EC3812E20B6DA13003FFC46 /* ChatViewController.swift in Sources */,
				5EC3801420B6D613003FFC46 /* AppDelegate.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXVariantGroup section */
		5EC3801720B6D613003FFC46 /* Main.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5EC3801820B6D613003FFC46 /* Base */,
			);
			name = Main.storyboard;
			sourceTree = "&lt;group&gt;";
		};
		5EC3801C20B6D614003FFC46 /* LaunchScreen.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5EC3801D20B6D614003FFC46 /* Base */,
			);
			name = LaunchScreen.storyboard;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
		5EC3802020B6D614003FFC46 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
				CLANG_CXX_LIBRARY = "libc++";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
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
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				CODE_SIGN_IDENTITY = "iPhone Developer";
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				GCC_C_LANGUAGE_STANDARD = gnu11;
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
				IPHONEOS_DEPLOYMENT_TARGET = 11.3;
				MTL_ENABLE_DEBUG_INFO = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
			};
			name = Debug;
		};
		5EC3802120B6D614003FFC46 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
				CLANG_CXX_LIBRARY = "libc++";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
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
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				CODE_SIGN_IDENTITY = "iPhone Developer";
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				GCC_C_LANGUAGE_STANDARD = gnu11;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 11.3;
				MTL_ENABLE_DEBUG_INFO = NO;
				SDKROOT = iphoneos;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		5EC3802320B6D614003FFC46 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CODE_SIGN_STYLE = Automatic;
				FRAMEWORK_SEARCH_PATHS = (
					"$(inherited)",
					"$(PROJECT_DIR)",
				);
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Chat/Info.plist";
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				LIBRARY_SEARCH_PATHS = "$(inherited)";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Chat";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_OBJC_BRIDGING_HEADER = "";
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		5EC3802420B6D614003FFC46 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CODE_SIGN_STYLE = Automatic;
				FRAMEWORK_SEARCH_PATHS = (
					"$(inherited)",
					"$(PROJECT_DIR)",
				);
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Chat/Info.plist";
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				LIBRARY_SEARCH_PATHS = "$(inherited)";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Chat";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_OBJC_BRIDGING_HEADER = "";
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		5EC3800B20B6D613003FFC46 /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Chat" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5EC3802020B6D614003FFC46 /* Debug */,
				5EC3802120B6D614003FFC46 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		5EC3802220B6D614003FFC46 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Chat" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5EC3802320B6D614003FFC46 /* Debug */,
				5EC3802420B6D614003FFC46 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = 5EC3800820B6D613003FFC46 /* Project object */;
}
          		</file>
        	</folder> 
      	</folder>
    </xsl:template>
</xsl:stylesheet>