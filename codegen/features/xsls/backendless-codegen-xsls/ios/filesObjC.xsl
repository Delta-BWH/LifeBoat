  <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
    <!-- @formatter:off -->
    
    <xsl:variable name="applicationName"      select="backendless-codegen/application/name"/>
    <xsl:variable name="applicationId"        select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey"               select="backendless-codegen/application/apiKeys/IOS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>
    
    <xsl:template name="filesObjC">
      <folder  hideContent="true"     name="{$applicationName}-Files">
        <file  hideContent="true"     path="backendless-codegen/ObjC/FileService/README.txt"/>
       
        <file name="Podfile">
target '<xsl:value-of select="$applicationName"/>-Files' do

use_frameworks!
pod 'BackendlessSwift'

end
        </file>
        
        <folder  hideContent="true"     name="{$applicationName}-Files">
          <folder  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/Assets.xcassets"/>
          <folder  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/Base.lproj"/>
          <file  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/AppDelegate.h"/>
          <file  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/FileObject.h"/>
          <file  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/FileObject.m"/>
          <file  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/BrowseViewController.h"/>
          <file  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/BrowseViewController.m"/>
          <file  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/ImagePreviewViewController.h"/>
          <file  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/ImagePreviewViewController.m"/>
          <file  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/Info.plist"/>
          <file  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/main.m"/>
          <file  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/ViewController.h"/>
          <file  hideContent="true"     path="backendless-codegen/ObjC/FileService/FileService/ViewController.m"/>
				
          <file  hideContent="true"     name="AppDelegate.m">
#import "AppDelegate.h"
#import &lt;Backendless-Swift.h&gt;

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

@end
          </file>
        </folder>
        
			  <folder  hideContent="true"     name="{$applicationName}-Files.xcodeproj">
          <file  hideContent="true"     name="project.pbxproj">// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 46;
	objects = {

/* Begin PBXBuildFile section */
		5A5E54CB1F0122F6009649AE /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 5A5E54CA1F0122F6009649AE /* Assets.xcassets */; };
		5AFCAD521EEA9C0000A3C1EA /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5AFCAD501EEA9C0000A3C1EA /* LaunchScreen.storyboard */; };
		5EEF4254227DE76500C74B45 /* FileObject.m in Sources */ = {isa = PBXBuildFile; fileRef = 5EEF4252227DE76500C74B45 /* FileObject.m */; };
		D323EA781A1BD07B001F84BD /* main.m in Sources */ = {isa = PBXBuildFile; fileRef = D323EA771A1BD07B001F84BD /* main.m */; };
		D323EA7B1A1BD07B001F84BD /* AppDelegate.m in Sources */ = {isa = PBXBuildFile; fileRef = D323EA7A1A1BD07B001F84BD /* AppDelegate.m */; };
		D323EA7E1A1BD07B001F84BD /* ViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = D323EA7D1A1BD07B001F84BD /* ViewController.m */; };
		D323EA811A1BD07B001F84BD /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = D323EA7F1A1BD07B001F84BD /* Main.storyboard */; };
		D323EAF81A1BD439001F84BD /* BrowseViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = D323EAF21A1BD439001F84BD /* BrowseViewController.m */; };
		D323EAF91A1BD439001F84BD /* ImagePreviewViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = D323EAF41A1BD439001F84BD /* ImagePreviewViewController.m */; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		5A5E54CA1F0122F6009649AE /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
		5AFCAD511EEA9C0000A3C1EA /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
		5EEF4252227DE76500C74B45 /* FileObject.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = FileObject.m; sourceTree = "&lt;group&gt;"; };
		5EEF4253227DE76500C74B45 /* FileObject.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = FileObject.h; sourceTree = "&lt;group&gt;"; };
		D323EA721A1BD07B001F84BD /* <xsl:value-of select="$applicationName"/>-Files.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "<xsl:value-of select="$applicationName"/>-Files.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		D323EA761A1BD07B001F84BD /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
		D323EA771A1BD07B001F84BD /* main.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = main.m; sourceTree = "&lt;group&gt;"; };
		D323EA791A1BD07B001F84BD /* AppDelegate.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = AppDelegate.h; sourceTree = "&lt;group&gt;"; };
		D323EA7A1A1BD07B001F84BD /* AppDelegate.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = AppDelegate.m; sourceTree = "&lt;group&gt;"; };
		D323EA7C1A1BD07B001F84BD /* ViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = ViewController.h; sourceTree = "&lt;group&gt;"; };
		D323EA7D1A1BD07B001F84BD /* ViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = ViewController.m; sourceTree = "&lt;group&gt;"; };
		D323EA801A1BD07B001F84BD /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "&lt;group&gt;"; };
		D323EAF11A1BD439001F84BD /* BrowseViewController.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = BrowseViewController.h; sourceTree = "&lt;group&gt;"; };
		D323EAF21A1BD439001F84BD /* BrowseViewController.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = BrowseViewController.m; sourceTree = "&lt;group&gt;"; };
		D323EAF31A1BD439001F84BD /* ImagePreviewViewController.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = ImagePreviewViewController.h; sourceTree = "&lt;group&gt;"; };
		D323EAF41A1BD439001F84BD /* ImagePreviewViewController.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = ImagePreviewViewController.m; sourceTree = "&lt;group&gt;"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		D323EA6F1A1BD07B001F84BD /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		D323EA691A1BD07B001F84BD = {
			isa = PBXGroup;
			children = (
				D323EA741A1BD07B001F84BD /* <xsl:value-of select="$applicationName"/>-Files */,
				D323EA731A1BD07B001F84BD /* Products */,
			);
			sourceTree = "&lt;group&gt;";
		};
		D323EA731A1BD07B001F84BD /* Products */ = {
			isa = PBXGroup;
			children = (
				D323EA721A1BD07B001F84BD /* <xsl:value-of select="$applicationName"/>-Files.app */,
			);
			name = Products;
			sourceTree = "&lt;group&gt;";
		};
		D323EA741A1BD07B001F84BD /* <xsl:value-of select="$applicationName"/>-Files */ = {
			isa = PBXGroup;
			children = (
				5A5E54CA1F0122F6009649AE /* Assets.xcassets */,
				D323EA7F1A1BD07B001F84BD /* Main.storyboard */,
				5AFCAD501EEA9C0000A3C1EA /* LaunchScreen.storyboard */,
				D323EA791A1BD07B001F84BD /* AppDelegate.h */,
				D323EA7A1A1BD07B001F84BD /* AppDelegate.m */,
				D323EA7C1A1BD07B001F84BD /* ViewController.h */,
				D323EA7D1A1BD07B001F84BD /* ViewController.m */,
				D323EAF11A1BD439001F84BD /* BrowseViewController.h */,
				D323EAF21A1BD439001F84BD /* BrowseViewController.m */,
				D323EAF31A1BD439001F84BD /* ImagePreviewViewController.h */,
				D323EAF41A1BD439001F84BD /* ImagePreviewViewController.m */,
				5EEF4253227DE76500C74B45 /* FileObject.h */,
				5EEF4252227DE76500C74B45 /* FileObject.m */,
				D323EA751A1BD07B001F84BD /* Supporting Files */,
			);
			path = "<xsl:value-of select="$applicationName"/>-Files";
			sourceTree = "&lt;group&gt;";
		};
		D323EA751A1BD07B001F84BD /* Supporting Files */ = {
			isa = PBXGroup;
			children = (
				D323EA761A1BD07B001F84BD /* Info.plist */,
				D323EA771A1BD07B001F84BD /* main.m */,
			);
			name = "Supporting Files";
			sourceTree = "&lt;group&gt;";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		D323EA711A1BD07B001F84BD /* <xsl:value-of select="$applicationName"/>-Files */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = D323EA951A1BD07B001F84BD /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Files" */;
			buildPhases = (
				D323EA6E1A1BD07B001F84BD /* Sources */,
				D323EA6F1A1BD07B001F84BD /* Frameworks */,
				D323EA701A1BD07B001F84BD /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = "<xsl:value-of select="$applicationName"/>-Files";
			productName = "<xsl:value-of select="$applicationName"/>-Files";
			productReference = D323EA721A1BD07B001F84BD /* <xsl:value-of select="$applicationName"/>-Files.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		D323EA6A1A1BD07B001F84BD /* Project object */ = {
			isa = PBXProject;
			attributes = {
				LastUpgradeCheck = 0930;
				TargetAttributes = {
					D323EA711A1BD07B001F84BD = {
						CreatedOnToolsVersion = 6.1;
					};
				};
			};
			buildConfigurationList = D323EA6D1A1BD07B001F84BD /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Files" */;
			compatibilityVersion = "Xcode 3.2";
			developmentRegion = English;
			hasScannedForEncodings = 0;
			knownRegions = (
				English,
				en,
				Base,
			);
			mainGroup = D323EA691A1BD07B001F84BD;
			productRefGroup = D323EA731A1BD07B001F84BD /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				D323EA711A1BD07B001F84BD /* <xsl:value-of select="$applicationName"/>-Files */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		D323EA701A1BD07B001F84BD /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5AFCAD521EEA9C0000A3C1EA /* LaunchScreen.storyboard in Resources */,
				5A5E54CB1F0122F6009649AE /* Assets.xcassets in Resources */,
				D323EA811A1BD07B001F84BD /* Main.storyboard in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		D323EA6E1A1BD07B001F84BD /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				D323EA7E1A1BD07B001F84BD /* ViewController.m in Sources */,
				D323EAF91A1BD439001F84BD /* ImagePreviewViewController.m in Sources */,
				D323EA7B1A1BD07B001F84BD /* AppDelegate.m in Sources */,
				D323EAF81A1BD439001F84BD /* BrowseViewController.m in Sources */,
				5EEF4254227DE76500C74B45 /* FileObject.m in Sources */,
				D323EA781A1BD07B001F84BD /* main.m in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXVariantGroup section */
		55AFCAD501EEA9C0000A3C1EA /* LaunchScreen.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5AFCAD511EEA9C0000A3C1EA /* Base */,
			);
			name = LaunchScreen.storyboard;
			sourceTree = "&lt;group&gt;";
		};
		D323EA7F1A1BD07B001F84BD /* Main.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				D323EA801A1BD07B001F84BD /* Base */,
			);
			name = Main.storyboard;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
		D323EA931A1BD07B001F84BD /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
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
				GCC_SYMBOLS_PRIVATE_EXTERN = NO;
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
			};
			name = Debug;
		};
		D323EA941A1BD07B001F84BD /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
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
				COPY_PHASE_STRIP = YES;
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
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		D323EA961A1BD07B001F84BD /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				HEADER_SEARCH_PATHS = "$(inherited)";
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Files/Info.plist";
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				LIBRARY_SEARCH_PATHS = "$(inherited)";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Files";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		D323EA971A1BD07B001F84BD /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				HEADER_SEARCH_PATHS = "$(inherited)";
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Files/Info.plist";
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				LIBRARY_SEARCH_PATHS = "$(inherited)";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Files";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		D323EA6D1A1BD07B001F84BD /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Files" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				D323EA931A1BD07B001F84BD /* Debug */,
				D323EA941A1BD07B001F84BD /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		D323EA951A1BD07B001F84BD /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Files" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				D323EA961A1BD07B001F84BD /* Debug */,
				D323EA971A1BD07B001F84BD /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = D323EA6A1A1BD07B001F84BD /* Project object */;
}
          </file>
	    </folder>
      </folder>
    </xsl:template>
</xsl:stylesheet>