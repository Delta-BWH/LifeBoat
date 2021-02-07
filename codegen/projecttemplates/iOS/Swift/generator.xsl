<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!--  @formatter:off  -->
    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/></xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/IOS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>
    
    <xsl:template match="/">
        <folder name="{$projectName}">
            <file path="Project/README.txt"/>
            <file name="Podfile">
target '<xsl:value-of select="$projectName"/>' do

use_frameworks!
pod 'BackendlessSwift'

end
            </file>

            <folder name="{$projectName}">
                <folder path="Project/ProjectFiles/Assets.xcassets"/>
                <folder path="Project/ProjectFiles/Base.lproj"/>
                <file path="Project/ProjectFiles/Info.plist"/>
                <file path="Project/ProjectFiles/ViewController.swift"/>
                <file name="AppDelegate.swift"> 
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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -&gt; Bool {
        initBackendless()
        return true
    }
}
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
        0F22E1AF1E8407D1004B722A /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 0F22E1AE1E8407D1004B722A /* AppDelegate.swift */; };
        0F22E1B11E8407D1004B722A /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 0F22E1B01E8407D1004B722A /* ViewController.swift */; };
        0F22E1B41E8407D1004B722A /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 0F22E1B21E8407D1004B722A /* Main.storyboard */; };
        0F22E1B61E8407D1004B722A /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 0F22E1B51E8407D1004B722A /* Assets.xcassets */; };
        0F22E1B91E8407D1004B722A /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 0F22E1B71E8407D1004B722A /* LaunchScreen.storyboard */; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
        0F22E1AB1E8407D1004B722A /* <xsl:value-of select="$projectName"/>.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = <xsl:value-of select="$projectName"/>.app; sourceTree = BUILT_PRODUCTS_DIR; };
        0F22E1AE1E8407D1004B722A /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "&lt;group&gt;"; };
        0F22E1B01E8407D1004B722A /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "&lt;group&gt;"; };
        0F22E1B31E8407D1004B722A /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "&lt;group&gt;"; };
        0F22E1B51E8407D1004B722A /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
        0F22E1B81E8407D1004B722A /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
        0F22E1BA1E8407D1004B722A /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
        0F22E1A81E8407D1004B722A /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
        0F22E1A21E8407D1004B722A = {
            isa = PBXGroup;
            children = (
                0F22E1AD1E8407D1004B722A /* <xsl:value-of select="$projectName"/> */,
                0F22E1AC1E8407D1004B722A /* Products */,
            );
            sourceTree = "&lt;group&gt;";
        };
        0F22E1AC1E8407D1004B722A /* Products */ = {
            isa = PBXGroup;
            children = (
                0F22E1AB1E8407D1004B722A /* <xsl:value-of select="$projectName"/>.app */,
            );
            name = Products;
            sourceTree = "&lt;group&gt;";
        };
        0F22E1AD1E8407D1004B722A /* <xsl:value-of select="$projectName"/> */ = {
            isa = PBXGroup;
            children = (
                0F22E1AE1E8407D1004B722A /* AppDelegate.swift */,
                0F22E1B01E8407D1004B722A /* ViewController.swift */,
                0F22E1B21E8407D1004B722A /* Main.storyboard */,
                0F22E1B51E8407D1004B722A /* Assets.xcassets */,
                0F22E1B71E8407D1004B722A /* LaunchScreen.storyboard */,
                0F22E1BA1E8407D1004B722A /* Info.plist */,
            );
            path = <xsl:value-of select="$projectName"/>;
            sourceTree = "&lt;group&gt;";
        };
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
        0F22E1AA1E8407D1004B722A /* <xsl:value-of select="$projectName"/> */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 0F22E1BD1E8407D1004B722A /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$projectName"/>" */;
            buildPhases = (
                0F22E1A71E8407D1004B722A /* Sources */,
                0F22E1A81E8407D1004B722A /* Frameworks */,
                0F22E1A91E8407D1004B722A /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
            );
            name = <xsl:value-of select="$projectName"/>;
            productName = <xsl:value-of select="$projectName"/>;
            productReference = 0F22E1AB1E8407D1004B722A /* <xsl:value-of select="$projectName"/>.app */;
            productType = "com.apple.product-type.application";
        };
/* End PBXNativeTarget section */

/* Begin PBXProject section */
        0F22E1A31E8407D1004B722A /* Project object */ = {
            isa = PBXProject;
            attributes = {
                LastSwiftUpdateCheck = 0820;
                LastUpgradeCheck = 1020;
                TargetAttributes = {
                    0F22E1AA1E8407D1004B722A = {
                        CreatedOnToolsVersion = 8.2.1;
                        LastSwiftMigration = 1020;
                        ProvisioningStyle = Automatic;
                    };
                };
            };
            buildConfigurationList = 0F22E1A61E8407D1004B722A /* Build configuration list for PBXProject "<xsl:value-of select="$projectName"/>" */;
            compatibilityVersion = "Xcode 3.2";
            developmentRegion = en;
            hasScannedForEncodings = 0;
            knownRegions = (
                en,
                Base,
            );
            mainGroup = 0F22E1A21E8407D1004B722A;
            productRefGroup = 0F22E1AC1E8407D1004B722A /* Products */;
            projectDirPath = "";
            projectRoot = "";
            targets = (
                0F22E1AA1E8407D1004B722A /* <xsl:value-of select="$projectName"/> */,
            );
        };
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
        0F22E1A91E8407D1004B722A /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                0F22E1B91E8407D1004B722A /* LaunchScreen.storyboard in Resources */,
                0F22E1B61E8407D1004B722A /* Assets.xcassets in Resources */,
                0F22E1B41E8407D1004B722A /* Main.storyboard in Resources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
        0F22E1A71E8407D1004B722A /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                0F22E1B11E8407D1004B722A /* ViewController.swift in Sources */,
                0F22E1AF1E8407D1004B722A /* AppDelegate.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXSourcesBuildPhase section */

/* Begin PBXVariantGroup section */
        0F22E1B21E8407D1004B722A /* Main.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                0F22E1B31E8407D1004B722A /* Base */,
            );
            name = Main.storyboard;
            sourceTree = "&lt;group&gt;";
        };
        0F22E1B71E8407D1004B722A /* LaunchScreen.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                0F22E1B81E8407D1004B722A /* Base */,
            );
            name = LaunchScreen.storyboard;
            sourceTree = "&lt;group&gt;";
        };
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
        0F22E1BB1E8407D1004B722A /* Debug */ = {
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
                SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
                SWIFT_OPTIMIZATION_LEVEL = "-Onone";
                SWIFT_VERSION = 4.0;
            };
            name = Debug;
        };
        0F22E1BC1E8407D1004B722A /* Release */ = {
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
                SWIFT_OPTIMIZATION_LEVEL = "-Owholemodule";
                SWIFT_VERSION = 4.0;
                VALIDATE_PRODUCT = YES;
            };
            name = Release;
        };
        0F22E1BE1E8407D1004B722A /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                INFOPLIST_FILE = <xsl:value-of select="$projectName"/>/Info.plist;
                LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
                LIBRARY_SEARCH_PATHS = "$(inherited)";
                PRODUCT_BUNDLE_IDENTIFIER = com.backendless.projecttemplates.<xsl:value-of select="$projectName"/>;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_OBJC_BRIDGING_HEADER = "";
                SWIFT_VERSION = 5.0;
            };
            name = Debug;
        };
        0F22E1BF1E8407D1004B722A /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                INFOPLIST_FILE = <xsl:value-of select="$projectName"/>/Info.plist;
                LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
                LIBRARY_SEARCH_PATHS = "$(inherited)";
                PRODUCT_BUNDLE_IDENTIFIER = com.backendless.projecttemplates.<xsl:value-of select="$projectName"/>;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_OBJC_BRIDGING_HEADER = "";
                SWIFT_VERSION = 5.0;
            };
            name = Release;
        };
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
        0F22E1A61E8407D1004B722A /* Build configuration list for PBXProject "<xsl:value-of select="$projectName"/>" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                0F22E1BB1E8407D1004B722A /* Debug */,
                0F22E1BC1E8407D1004B722A /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        0F22E1BD1E8407D1004B722A /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$projectName"/>" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                0F22E1BE1E8407D1004B722A /* Debug */,
                0F22E1BF1E8407D1004B722A /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
/* End XCConfigurationList section */
    };
    rootObject = 0F22E1A31E8407D1004B722A /* Project object */;
}
                </file>
            </folder>
        </folder>
    </xsl:template>
</xsl:stylesheet>