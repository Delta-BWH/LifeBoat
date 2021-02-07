  <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
    <!-- @formatter:off -->
    
    <xsl:variable name="applicationName"      select="backendless-codegen/application/name"/>
    <xsl:variable name="applicationId"        select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey"               select="backendless-codegen/application/apiKeys/IOS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>
    
    <xsl:template name="filesSwift">
      <folder  hideContent="true"    name="{$applicationName}-Files">
        <file  hideContent="true"    path="backendless-codegen/Swift/FileService/README.txt"/>
       
        <file name="Podfile">
target '<xsl:value-of select="$applicationName"/>-Files' do

use_frameworks!
pod 'BackendlessSwift'

end
        </file>
        
        <folder  hideContent="true"     name="{$applicationName}-Files">
          <folder  hideContent="true"     path="backendless-codegen/Swift/FileService/FileService/Assets.xcassets"/>
          <folder  hideContent="true"     path="backendless-codegen/Swift/FileService/FileService/Base.lproj"/>
          <file  hideContent="true"     path="backendless-codegen/Swift/FileService/FileService/ViewController.swift"/>
          <file  hideContent="true"     path="backendless-codegen/Swift/FileService/FileService/FileObject.swift"/>
          <file  hideContent="true"     path="backendless-codegen/Swift/FileService/FileService/BrowseViewController.swift"/>
          <file  hideContent="true"     path="backendless-codegen/Swift/FileService/FileService/ImagePreviewViewController.swift"/>
          <file  hideContent="true"     path="backendless-codegen/Swift/FileService/FileService/Info.plist"/>
				
          <file  hideContent="true"     name="AppDelegate.swift">

import UIKit
import Backendless

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let APPLICATION_ID = "<xsl:value-of select="$applicationId"/>"
    private let API_KEY = "<xsl:value-of select="$apiKey"/>"
    private let SERVER_URL = "<xsl:value-of select="$serverURL"/>"

    var window: UIWindow?

    private func initBackendless() {
        Backendless.shared.hostUrl = SERVER_URL
        Backendless.shared.initApp(applicationId: APPLICATION_ID, apiKey: API_KEY)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -&gt; Bool {
        initBackendless()
        return true
    }
}
          </file>
        </folder>
        
			  <folder  hideContent="true"  name="{$applicationName}-Files.xcodeproj">
          <file  hideContent="true"    name="project.pbxproj">// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 46;
	objects = {

/* Begin PBXBuildFile section */
		5A0127841EFBF3280064B4FB /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5A0127831EFBF3280064B4FB /* AppDelegate.swift */; };
		5A0127861EFBF3280064B4FB /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5A0127851EFBF3280064B4FB /* ViewController.swift */; };
		5A01278B1EFBF3280064B4FB /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 5A01278A1EFBF3280064B4FB /* Assets.xcassets */; };
		5A01279A1EFBF36E0064B4FB /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5A0127971EFBF36E0064B4FB /* Main.storyboard */; };
		5A01279C1EFBF9C10064B4FB /* ImagePreviewViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5A01279B1EFBF9C10064B4FB /* ImagePreviewViewController.swift */; };
		5A01279E1EFBFC1C0064B4FB /* FileObject.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5A01279D1EFBFC1C0064B4FB /* FileObject.swift */; };
		5A2130731EFD2DD6004DB09B /* BrowseViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5A2130721EFD2DD6004DB09B /* BrowseViewController.swift */; };
		5A695D0C1F00F631008C6755 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5A695D0A1F00F631008C6755 /* LaunchScreen.storyboard */; };
/* End PBXBuildFile section */

/* Begin PBXCopyFilesBuildPhase section */
		5E88F7DA227F145F00BED27B /* Embed Frameworks */ = {
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
		5A0127801EFBF3280064B4FB /* <xsl:value-of select="$applicationName"/>-Files.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "<xsl:value-of select="$applicationName"/>-Files.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		5A0127831EFBF3280064B4FB /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "&lt;group&gt;"; };
		5A0127851EFBF3280064B4FB /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "&lt;group&gt;"; };
		5A01278A1EFBF3280064B4FB /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
		5A01278F1EFBF3280064B4FB /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
		5A0127981EFBF36E0064B4FB /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = "<xsl:value-of select="$applicationName"/>-Files/Base.lproj/Main.storyboard"; sourceTree = "&lt;group&gt;"; };
		5A01279B1EFBF9C10064B4FB /* ImagePreviewViewController.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = ImagePreviewViewController.swift; sourceTree = "&lt;group&gt;"; };
		5A01279D1EFBFC1C0064B4FB /* FileObject.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = FileObject.swift; sourceTree = "&lt;group&gt;"; };
		5A2130721EFD2DD6004DB09B /* BrowseViewController.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = BrowseViewController.swift; sourceTree = "&lt;group&gt;"; };
		5A695D0B1F00F631008C6755 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		5A01277D1EFBF3280064B4FB /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */		
		5A0127771EFBF3280064B4FB = {
			isa = PBXGroup;
			children = (
				5A0127821EFBF3280064B4FB /* <xsl:value-of select="$applicationName"/>-Files */,
				5A0127811EFBF3280064B4FB /* Products */,
			);
			sourceTree = "&lt;group&gt;";
		};
		5A0127811EFBF3280064B4FB /* Products */ = {
			isa = PBXGroup;
			children = (
				5A0127801EFBF3280064B4FB /* <xsl:value-of select="$applicationName"/>-Files.app */,
			);
			name = Products;
			sourceTree = "&lt;group&gt;";
		};
		5A0127821EFBF3280064B4FB /* <xsl:value-of select="$applicationName"/>-Files */ = {
			isa = PBXGroup;
			children = (
				5A0127831EFBF3280064B4FB /* AppDelegate.swift */,
				5A0127851EFBF3280064B4FB /* ViewController.swift */,
				5A2130721EFD2DD6004DB09B /* BrowseViewController.swift */,
				5A01279B1EFBF9C10064B4FB /* ImagePreviewViewController.swift */,
				5A01279D1EFBFC1C0064B4FB /* FileObject.swift */,
				5A0127971EFBF36E0064B4FB /* Main.storyboard */,
				5A695D0A1F00F631008C6755 /* LaunchScreen.storyboard */,
				5A01278F1EFBF3280064B4FB /* Info.plist */,
				5A01278A1EFBF3280064B4FB /* Assets.xcassets */,
			);
			path = "<xsl:value-of select="$applicationName"/>-Files";
			sourceTree = "&lt;group&gt;";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		5A01277F1EFBF3280064B4FB /* <xsl:value-of select="$applicationName"/>-Files */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 5A0127921EFBF3280064B4FB /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Files" */;
			buildPhases = (
				5A01277C1EFBF3280064B4FB /* Sources */,
				5A01277D1EFBF3280064B4FB /* Frameworks */,
				5A01277E1EFBF3280064B4FB /* Resources */,
				5E88F7DA227F145F00BED27B /* Embed Frameworks */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = "<xsl:value-of select="$applicationName"/>-Files";
			productName = "<xsl:value-of select="$applicationName"/>-Files";
			productReference = 5A0127801EFBF3280064B4FB /* <xsl:value-of select="$applicationName"/>-Files.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		5A0127781EFBF3280064B4FB /* Project object */ = {
			isa = PBXProject;
			attributes = {
				LastSwiftUpdateCheck = 0830;
				LastUpgradeCheck = 1020;
				TargetAttributes = {
					5A01277F1EFBF3280064B4FB = {
						CreatedOnToolsVersion = 8.3.2;
						ProvisioningStyle = Automatic;
					};
				};
			};
			buildConfigurationList = 5A01277B1EFBF3280064B4FB /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Files" */;
			compatibilityVersion = "Xcode 3.2";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = 5A0127771EFBF3280064B4FB;
			productRefGroup = 5A0127811EFBF3280064B4FB /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				5A01277F1EFBF3280064B4FB /* <xsl:value-of select="$applicationName"/>-Files */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		5A01277E1EFBF3280064B4FB /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5A695D0C1F00F631008C6755 /* LaunchScreen.storyboard in Resources */,
				5A01279A1EFBF36E0064B4FB /* Main.storyboard in Resources */,
				5A01278B1EFBF3280064B4FB /* Assets.xcassets in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		5A01277C1EFBF3280064B4FB /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5A2130731EFD2DD6004DB09B /* BrowseViewController.swift in Sources */,
				5A0127861EFBF3280064B4FB /* ViewController.swift in Sources */,
				5A01279C1EFBF9C10064B4FB /* ImagePreviewViewController.swift in Sources */,
				5A01279E1EFBFC1C0064B4FB /* FileObject.swift in Sources */,
				5A0127841EFBF3280064B4FB /* AppDelegate.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXVariantGroup section */
		5A0127971EFBF36E0064B4FB /* Main.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5A0127981EFBF36E0064B4FB /* Base */,
			);
			name = Main.storyboard;
			path = ..;
			sourceTree = "&lt;group&gt;";
		};
		5A695D0A1F00F631008C6755 /* LaunchScreen.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5A695D0B1F00F631008C6755 /* Base */,
			);
			name = LaunchScreen.storyboard;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
		5A0127901EFBF3280064B4FB /* Debug */ = {
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
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		5A0127911EFBF3280064B4FB /* Release */ = {
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
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		5A0127931EFBF3280064B4FB /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				FRAMEWORK_SEARCH_PATHS = (
					"$(inherited)",
					"$(PROJECT_DIR)",
				);
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Files/Info.plist";
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				LIBRARY_SEARCH_PATHS = "$(inherited)";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Files";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_OBJC_BRIDGING_HEADER = "";
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		5A0127941EFBF3280064B4FB /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				FRAMEWORK_SEARCH_PATHS = (
					"$(inherited)",
					"$(PROJECT_DIR)",
				);
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Files/Info.plist";
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				LIBRARY_SEARCH_PATHS = "$(inherited)";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Files";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_OBJC_BRIDGING_HEADER = "";
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		5A01277B1EFBF3280064B4FB /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Files" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5A0127901EFBF3280064B4FB /* Debug */,
				5A0127911EFBF3280064B4FB /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		5A0127921EFBF3280064B4FB /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Files" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5A0127931EFBF3280064B4FB /* Debug */,
				5A0127941EFBF3280064B4FB /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = 5A0127781EFBF3280064B4FB /* Project object */;
}
          </file>
		    </folder>
      </folder>
    </xsl:template>
</xsl:stylesheet>