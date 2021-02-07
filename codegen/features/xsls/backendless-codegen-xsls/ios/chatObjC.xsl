<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
    <!-- @formatter:off -->

 	<xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/IOS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>

    <xsl:template name="chatObjC">
     	<folder  hideContent="true"    name="{$applicationName}-Chat">
        	<file  hideContent="true"    path="backendless-codegen/ObjC/Chat/README.txt"/>

        	<file name="Podfile">
target '<xsl:value-of select="$applicationName"/>-Chat' do

use_frameworks!
pod 'BackendlessSwift'

end
        	</file>
        
        	<folder  hideContent="true" name="{$applicationName}-Chat">
          		<folder  hideContent="true" path="backendless-codegen/ObjC/Chat/Chat/Base.lproj"/>
          		<folder  hideContent="true" path="backendless-codegen/ObjC/Chat/Chat/Assets.xcassets"/>
          		<file  hideContent="true" path="backendless-codegen/ObjC/Chat/Chat/Info.plist"/>
          		<file  hideContent="true" path="backendless-codegen/ObjC/Chat/Chat/main.m"/>
           		<file  hideContent="true" path="backendless-codegen/ObjC/Chat/Chat/AppDelegate.h"/>
          		<file  hideContent="true" path="backendless-codegen/ObjC/Chat/Chat/ChatViewController.h"/>
          		<file  hideContent="true" path="backendless-codegen/ObjC/Chat/Chat/ChatViewController.m"/>
         		  <file  hideContent="true" path="backendless-codegen/ObjC/Chat/Chat/ViewController.h"/>
         		  <file  hideContent="true" path="backendless-codegen/ObjC/Chat/Chat/ViewController.m"/>
          
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
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.window endEditing:YES];
}

@end
         		</file>   
 			</folder>
        
        	<folder  hideContent="true"  name="{$applicationName}-Chat.xcodeproj">
         		<file  hideContent="true"    name="project.pbxproj">// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 50;
	objects = {

/* Begin PBXBuildFile section */
		5E0C24B120B5C005003C80F4 /* AppDelegate.m in Sources */ = {isa = PBXBuildFile; fileRef = 5E0C24B020B5C005003C80F4 /* AppDelegate.m */; };
		5E0C24B420B5C005003C80F4 /* ViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5E0C24B320B5C005003C80F4 /* ViewController.m */; };
		5E0C24B720B5C005003C80F4 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5E0C24B520B5C005003C80F4 /* Main.storyboard */; };
		5E0C24B920B5C006003C80F4 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 5E0C24B820B5C006003C80F4 /* Assets.xcassets */; };
		5E0C24BC20B5C006003C80F4 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5E0C24BA20B5C006003C80F4 /* LaunchScreen.storyboard */; };
		5E0C24BF20B5C006003C80F4 /* main.m in Sources */ = {isa = PBXBuildFile; fileRef = 5E0C24BE20B5C006003C80F4 /* main.m */; };
		5E0C24C720B5C4F5003C80F4 /* ChatViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5E0C24C620B5C4F5003C80F4 /* ChatViewController.m */; };
/* End PBXBuildFile section */

/* Begin PBXCopyFilesBuildPhase section */
		5ECB87B0227C7EF7004DBFDC /* Embed Frameworks */ = {
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
		5E0C24AC20B5C005003C80F4 /* <xsl:value-of select="$applicationName"/>-Chat.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "<xsl:value-of select="$applicationName"/>-Chat.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		5E0C24AF20B5C005003C80F4 /* AppDelegate.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = AppDelegate.h; sourceTree = "&lt;group&gt;"; };
		5E0C24B020B5C005003C80F4 /* AppDelegate.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = AppDelegate.m; sourceTree = "&lt;group&gt;"; };
		5E0C24B220B5C005003C80F4 /* ViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = ViewController.h; sourceTree = "&lt;group&gt;"; };
		5E0C24B320B5C005003C80F4 /* ViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = ViewController.m; sourceTree = "&lt;group&gt;"; };
		5E0C24B620B5C005003C80F4 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "&lt;group&gt;"; };
		5E0C24B820B5C006003C80F4 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
		5E0C24BB20B5C006003C80F4 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
		5E0C24BD20B5C006003C80F4 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
		5E0C24BE20B5C006003C80F4 /* main.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = main.m; sourceTree = "&lt;group&gt;"; };
		5E0C24C520B5C4F5003C80F4 /* ChatViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = ChatViewController.h; sourceTree = "&lt;group&gt;"; };
		5E0C24C620B5C4F5003C80F4 /* ChatViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = ChatViewController.m; sourceTree = "&lt;group&gt;"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		5E0C24A920B5C005003C80F4 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		5E0C24A320B5C005003C80F4 = {
			isa = PBXGroup;
			children = (
				5E0C24AE20B5C005003C80F4 /* <xsl:value-of select="$applicationName"/>-Chat */,
				5E0C24AD20B5C005003C80F4 /* Products */,
				7AD175B49979B0B584481234 /* Pods */,
			);
			sourceTree = "&lt;group&gt;";
		};
		5E0C24AD20B5C005003C80F4 /* Products */ = {
			isa = PBXGroup;
			children = (
				5E0C24AC20B5C005003C80F4 /* <xsl:value-of select="$applicationName"/>-Chat.app */,
			);
			name = Products;
			sourceTree = "&lt;group&gt;";
		};
		5E0C24AE20B5C005003C80F4 /* <xsl:value-of select="$applicationName"/>-Chat */ = {
			isa = PBXGroup;
			children = (
				5E0C24AF20B5C005003C80F4 /* AppDelegate.h */,
				5E0C24B020B5C005003C80F4 /* AppDelegate.m */,
				5E0C24B220B5C005003C80F4 /* ViewController.h */,
				5E0C24B320B5C005003C80F4 /* ViewController.m */,
				5E0C24C520B5C4F5003C80F4 /* ChatViewController.h */,
				5E0C24C620B5C4F5003C80F4 /* ChatViewController.m */,
				5E0C24B520B5C005003C80F4 /* Main.storyboard */,
				5E0C24B820B5C006003C80F4 /* Assets.xcassets */,
				5E0C24BA20B5C006003C80F4 /* LaunchScreen.storyboard */,
				5E0C24BD20B5C006003C80F4 /* Info.plist */,
				5E0C24BE20B5C006003C80F4 /* main.m */,
			);
			path = "<xsl:value-of select="$applicationName"/>-Chat";
			sourceTree = "&lt;group&gt;";
		};
		7AD175B49979B0B584481234 /* Pods */ = {
			isa = PBXGroup;
			children = (
			);
			path = Pods;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		5E0C24AB20B5C005003C80F4 /* <xsl:value-of select="$applicationName"/>-Chat */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 5E0C24C220B5C006003C80F4 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Chat" */;
			buildPhases = (
				5E0C24A820B5C005003C80F4 /* Sources */,
				5E0C24A920B5C005003C80F4 /* Frameworks */,
				5E0C24AA20B5C005003C80F4 /* Resources */,
				5ECB87B0227C7EF7004DBFDC /* Embed Frameworks */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = "<xsl:value-of select="$applicationName"/>-Chat";
			productName = "<xsl:value-of select="$applicationName"/>-Chat";
			productReference = 5E0C24AC20B5C005003C80F4 /* <xsl:value-of select="$applicationName"/>-Chat.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		5E0C24A420B5C005003C80F4 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				LastUpgradeCheck = 0930;
				ORGANIZATIONNAME = Backendless;
				TargetAttributes = {
					5E0C24AB20B5C005003C80F4 = {
						CreatedOnToolsVersion = 9.3.1;
					};
				};
			};
			buildConfigurationList = 5E0C24A720B5C005003C80F4 /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Chat" */;
			compatibilityVersion = "Xcode 9.3";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = 5E0C24A320B5C005003C80F4;
			productRefGroup = 5E0C24AD20B5C005003C80F4 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				5E0C24AB20B5C005003C80F4 /* <xsl:value-of select="$applicationName"/>-Chat */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		5E0C24AA20B5C005003C80F4 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5E0C24BC20B5C006003C80F4 /* LaunchScreen.storyboard in Resources */,
				5E0C24B920B5C006003C80F4 /* Assets.xcassets in Resources */,
				5E0C24B720B5C005003C80F4 /* Main.storyboard in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		5E0C24A820B5C005003C80F4 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5E0C24B420B5C005003C80F4 /* ViewController.m in Sources */,
				5E0C24BF20B5C006003C80F4 /* main.m in Sources */,
				5E0C24C720B5C4F5003C80F4 /* ChatViewController.m in Sources */,
				5E0C24B120B5C005003C80F4 /* AppDelegate.m in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXVariantGroup section */
		5E0C24B520B5C005003C80F4 /* Main.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5E0C24B620B5C005003C80F4 /* Base */,
			);
			name = Main.storyboard;
			sourceTree = "&lt;group&gt;";
		};
		5E0C24BA20B5C006003C80F4 /* LaunchScreen.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5E0C24BB20B5C006003C80F4 /* Base */,
			);
			name = LaunchScreen.storyboard;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
		5E0C24C020B5C006003C80F4 /* Debug */ = {
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
			};
			name = Debug;
		};
		5E0C24C120B5C006003C80F4 /* Release */ = {
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
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		5E0C24C320B5C006003C80F4 /* Debug */ = {
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
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		5E0C24C420B5C006003C80F4 /* Release */ = {
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
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		5E0C24A720B5C005003C80F4 /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Chat" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5E0C24C020B5C006003C80F4 /* Debug */,
				5E0C24C120B5C006003C80F4 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		5E0C24C220B5C006003C80F4 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Chat" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5E0C24C320B5C006003C80F4 /* Debug */,
				5E0C24C420B5C006003C80F4 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = 5E0C24A420B5C005003C80F4 /* Project object */;
}
         		</file>
        	</folder>
  		</folder>
    </xsl:template>
</xsl:stylesheet>