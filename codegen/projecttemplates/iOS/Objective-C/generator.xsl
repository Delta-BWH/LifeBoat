 <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/></xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/IOS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>

    <xsl:template match="/">
        <folder name="{$projectName}">
          <file path = "Project/README.txt"/>
          <file name="Podfile">
target '<xsl:value-of select="$projectName"/>' do

use_frameworks!
pod 'BackendlessSwift'

end
          </file>
          <folder name="{$projectName}">
            <folder path = "Project/ProjectFiles/Assets.xcassets"/>
            <folder path = "Project/ProjectFiles/Base.lproj"/>
            <file path = "Project/ProjectFiles/AppDelegate.h"/>
            <file path = "Project/ProjectFiles/Info.plist"/>
            <file path = "Project/ProjectFiles/main.m"/>
            <file path = "Project/ProjectFiles/ViewController.h"/>
            <file path = "Project/ProjectFiles/ViewController.m"/>
                  
            <file name="AppDelegate.m">
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
              
          <folder name="{$projectName}.xcodeproj">
            <file name="project.pbxproj">// !$*UTF8*$!
{
    archiveVersion = 1;
    classes = {
    };
    objectVersion = 46;
    objects = {

/* Begin PBXBuildFile section */
        0F7A63311E769BB6007B6B07 /* main.m in Sources */ = {isa = PBXBuildFile; fileRef = 0F7A63301E769BB6007B6B07 /* main.m */; };
        0F7A63341E769BB6007B6B07 /* AppDelegate.m in Sources */ = {isa = PBXBuildFile; fileRef = 0F7A63331E769BB6007B6B07 /* AppDelegate.m */; };
        0F7A63371E769BB6007B6B07 /* ViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 0F7A63361E769BB6007B6B07 /* ViewController.m */; };
        0F7A633A1E769BB6007B6B07 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 0F7A63381E769BB6007B6B07 /* Main.storyboard */; };
        0F7A633C1E769BB6007B6B07 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 0F7A633B1E769BB6007B6B07 /* Assets.xcassets */; };
        0F7A633F1E769BB6007B6B07 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 0F7A633D1E769BB6007B6B07 /* LaunchScreen.storyboard */; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
        0F7A632C1E769BB6007B6B07 /* <xsl:value-of select="$projectName"/>.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = <xsl:value-of select="$projectName"/>.app; sourceTree = BUILT_PRODUCTS_DIR; };
        0F7A63301E769BB6007B6B07 /* main.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = main.m; sourceTree = "&lt;group&gt;"; };
        0F7A63321E769BB6007B6B07 /* AppDelegate.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = AppDelegate.h; sourceTree = "&lt;group&gt;"; };
        0F7A63331E769BB6007B6B07 /* AppDelegate.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = AppDelegate.m; sourceTree = "&lt;group&gt;"; };
        0F7A63351E769BB6007B6B07 /* ViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = ViewController.h; sourceTree = "&lt;group&gt;"; };
        0F7A63361E769BB6007B6B07 /* ViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = ViewController.m; sourceTree = "&lt;group&gt;"; };
        0F7A63391E769BB6007B6B07 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "&lt;group&gt;"; };
        0F7A633B1E769BB6007B6B07 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
        0F7A633E1E769BB6007B6B07 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
        0F7A63401E769BB6007B6B07 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
        0F7A63291E769BB6007B6B07 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
        0F7A63231E769BB6007B6B07 = {
            isa = PBXGroup;
            children = (
                0F7A632E1E769BB6007B6B07 /* <xsl:value-of select="$projectName"/> */,
                0F7A632D1E769BB6007B6B07 /* Products */,
            );
            sourceTree = "&lt;group&gt;";
        };
        0F7A632D1E769BB6007B6B07 /* Products */ = {
            isa = PBXGroup;
            children = (
                0F7A632C1E769BB6007B6B07 /* <xsl:value-of select="$projectName"/>.app */,
            );
            name = Products;
            sourceTree = "&lt;group&gt;";
        };
        0F7A632E1E769BB6007B6B07 /* <xsl:value-of select="$projectName"/> */ = {
            isa = PBXGroup;
            children = (
                0F7A63321E769BB6007B6B07 /* AppDelegate.h */,
                0F7A63331E769BB6007B6B07 /* AppDelegate.m */,
                0F7A63351E769BB6007B6B07 /* ViewController.h */,
                0F7A63361E769BB6007B6B07 /* ViewController.m */,
                0F7A63381E769BB6007B6B07 /* Main.storyboard */,
                0F7A633B1E769BB6007B6B07 /* Assets.xcassets */,
                0F7A633D1E769BB6007B6B07 /* LaunchScreen.storyboard */,
                0F7A63401E769BB6007B6B07 /* Info.plist */,
                0F7A632F1E769BB6007B6B07 /* Supporting Files */,
            );
            path = <xsl:value-of select="$projectName"/>;
            sourceTree = "&lt;group&gt;";
        };
        0F7A632F1E769BB6007B6B07 /* Supporting Files */ = {
            isa = PBXGroup;
            children = (
                0F7A63301E769BB6007B6B07 /* main.m */,
            );
            name = "Supporting Files";
            sourceTree = "&lt;group&gt;";
        };
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
        0F7A632B1E769BB6007B6B07 /* <xsl:value-of select="$projectName"/> */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 0F7A63431E769BB6007B6B07 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$projectName"/>" */;
            buildPhases = (
                0F7A63281E769BB6007B6B07 /* Sources */,
                0F7A63291E769BB6007B6B07 /* Frameworks */,
                0F7A632A1E769BB6007B6B07 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
            );
            name = <xsl:value-of select="$projectName"/>;
            productName = <xsl:value-of select="$projectName"/>;
            productReference = 0F7A632C1E769BB6007B6B07 /* <xsl:value-of select="$projectName"/>.app */;
            productType = "com.apple.product-type.application";
        };
/* End PBXNativeTarget section */

/* Begin PBXProject section */
        0F7A63241E769BB6007B6B07 /* Project object */ = {
            isa = PBXProject;
            attributes = {
                LastUpgradeCheck = 1020;
                TargetAttributes = {
                    0F7A632B1E769BB6007B6B07 = {
                        CreatedOnToolsVersion = 8.2.1;
                        ProvisioningStyle = Automatic;
                    };
                };
            };
            buildConfigurationList = 0F7A63271E769BB6007B6B07 /* Build configuration list for PBXProject "<xsl:value-of select="$projectName"/>" */;
            compatibilityVersion = "Xcode 3.2";
            developmentRegion = en;
            hasScannedForEncodings = 0;
            knownRegions = (
                en,
                Base,
            );
            mainGroup = 0F7A63231E769BB6007B6B07;
            productRefGroup = 0F7A632D1E769BB6007B6B07 /* Products */;
            projectDirPath = "";
            projectRoot = "";
            targets = (
                0F7A632B1E769BB6007B6B07 /* <xsl:value-of select="$projectName"/> */,
            );
        };
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
        0F7A632A1E769BB6007B6B07 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                0F7A633F1E769BB6007B6B07 /* LaunchScreen.storyboard in Resources */,
                0F7A633C1E769BB6007B6B07 /* Assets.xcassets in Resources */,
                0F7A633A1E769BB6007B6B07 /* Main.storyboard in Resources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
        0F7A63281E769BB6007B6B07 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                0F7A63371E769BB6007B6B07 /* ViewController.m in Sources */,
                0F7A63341E769BB6007B6B07 /* AppDelegate.m in Sources */,
                0F7A63311E769BB6007B6B07 /* main.m in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXSourcesBuildPhase section */

/* Begin PBXVariantGroup section */
        0F7A63381E769BB6007B6B07 /* Main.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                0F7A63391E769BB6007B6B07 /* Base */,
            );
            name = Main.storyboard;
            sourceTree = "&lt;group&gt;";
        };
        0F7A633D1E769BB6007B6B07 /* LaunchScreen.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                0F7A633E1E769BB6007B6B07 /* Base */,
            );
            name = LaunchScreen.storyboard;
            sourceTree = "&lt;group&gt;";
        };
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
        0F7A63411E769BB6007B6B07 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED = YES;
                CLANG_ANALYZER_NONNULL = YES;
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
            };
            name = Debug;
        };
        0F7A63421E769BB6007B6B07 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED = YES;
                CLANG_ANALYZER_NONNULL = YES;
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
                VALIDATE_PRODUCT = YES;
            };
            name = Release;
        };
        0F7A63441E769BB6007B6B07 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                INFOPLIST_FILE = <xsl:value-of select="$projectName"/>/Info.plist;
                IPHONEOS_DEPLOYMENT_TARGET = 8.0;
                LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
                LIBRARY_SEARCH_PATHS = "$(inherited)";
                PRODUCT_BUNDLE_IDENTIFIER = com.backendless.projecttemplates.<xsl:value-of select="$projectName"/>;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_VERSION = 4.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Debug;
        };
        0F7A63451E769BB6007B6B07 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                INFOPLIST_FILE = <xsl:value-of select="$projectName"/>/Info.plist;
                IPHONEOS_DEPLOYMENT_TARGET = 8.0;
                LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
                LIBRARY_SEARCH_PATHS = "$(inherited)";
                PRODUCT_BUNDLE_IDENTIFIER = com.backendless.projecttemplates.<xsl:value-of select="$projectName"/>;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_VERSION = 4.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Release;
        };
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
        0F7A63271E769BB6007B6B07 /* Build configuration list for PBXProject "<xsl:value-of select="$projectName"/>" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                0F7A63411E769BB6007B6B07 /* Debug */,
                0F7A63421E769BB6007B6B07 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        0F7A63431E769BB6007B6B07 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$projectName"/>" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                0F7A63441E769BB6007B6B07 /* Debug */,
                0F7A63451E769BB6007B6B07 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
/* End XCConfigurationList section */
    };
    rootObject = 0F7A63241E769BB6007B6B07 /* Project object */;
}
            </file>
          </folder>
        </folder>
    </xsl:template>
</xsl:stylesheet>