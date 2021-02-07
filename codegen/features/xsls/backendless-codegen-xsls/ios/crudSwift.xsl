  <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
    <!-- @formatter:off -->

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/IOS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>
    <xsl:variable name="tables" select="backendless-codegen/application/tables"/>
    <xsl:variable name="usersTableId" select="backendless-codegen/application/tables/table[name = 'Users']/tableId"/>

    <xsl:template name="crudSwift">
      <folder  hideContent="true"    name="{$applicationName}-CRUD">
        <file  hideContent="true"    path="backendless-codegen/Swift/CRUD/README.txt"/>
          
        <file name="Podfile">
target '<xsl:value-of select="$applicationName"/>-CRUD' do

use_frameworks!
pod 'BackendlessSwift'

end
        </file>
        
        <folder  hideContent="true"    name="{$applicationName}-CRUD">
          <folder  hideContent="true"    path="backendless-codegen/Swift/CRUD/CRUD/Base.lproj"/>
          <folder  hideContent="true"    path="backendless-codegen/Swift/CRUD/CRUD/Assets.xcassets"/>
          <folder  hideContent="true"    path="backendless-codegen/Swift/CRUD/CRUD/Utils"/>
          <folder  hideContent="true"    path="backendless-codegen/Swift/CRUD/CRUD/ViewControllers"/>
          <file  hideContent="true"    path="backendless-codegen/Swift/CRUD/CRUD/Info.plist"/>
          
          <file  hideContent="true"    name="AppDelegate.swift">
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
          
          <folder  hideContent="true"  name="ViewControllers">
            <file  hideContent="true"    name="TablesViewController.swift">
import UIKit
import Backendless

class TablesViewController: UITableViewController {
    
    private let SHOW_CRUD = "ShowCrudOperations"
    
    private var tableNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getTables()
    }
    
    func getTables() {
        var tables = "<xsl:for-each select="$tables/table[name != 'Users']"><xsl:value-of select="name"/>, </xsl:for-each>"
        tables = String(tables.dropLast(2))
        tableNames = tables.components(separatedBy: ", ")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -&gt; Int {
        return tableNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -&gt; UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableNameCell", for: indexPath)
        cell.textLabel?.text = tableNames[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SHOW_CRUD, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let crudOperationsVC = segue.destination as? CrudOperationsViewController,
            let indexPath = sender as? IndexPath {
            crudOperationsVC.tableName = tableNames[indexPath.row]
        }
    }
}
            </file>
          </folder>
        </folder>
        
        <folder  hideContent="true"  name="{$applicationName}-CRUD.xcodeproj">
          <file  hideContent="true"    name="project.pbxproj">// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 51;
	objects = {

/* Begin PBXBuildFile section */
		5E1DBE2C22CA6FED0005ED9F /* SortViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5E1DBE2B22CA6FED0005ED9F /* SortViewController.swift */; };
		5E2D690722CA313400E63B09 /* PropertiesViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5E2D690622CA313400E63B09 /* PropertiesViewController.swift */; };
		5E2D690922CA376B00E63B09 /* ObjectsViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5E2D690822CA376B00E63B09 /* ObjectsViewController.swift */; };
		5E45D8CC22C8CF42005099F0 /* CodeSampleViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5E45D8CB22C8CF42005099F0 /* CodeSampleViewController.swift */; };
		5E45D8CE22C8CF61005099F0 /* RetrieveViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5E45D8CD22C8CF61005099F0 /* RetrieveViewController.swift */; };
		5E45D8D022C8D15E005099F0 /* Utils.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5E45D8CF22C8D15E005099F0 /* Utils.swift */; };
		5E6296CC22CB406A00D9B91F /* RelatedViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5E6296CB22CB406A00D9B91F /* RelatedViewController.swift */; };
		5E6296CF22CB4DF600D9B91F /* ObjectsWithRelationsViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5E6296CE22CB4DF600D9B91F /* ObjectsWithRelationsViewController.swift */; };
		5EFBC47222C8BAF500B30167 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5EFBC47122C8BAF500B30167 /* AppDelegate.swift */; };
		5EFBC47922C8BAF600B30167 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 5EFBC47822C8BAF600B30167 /* Assets.xcassets */; };
		5EFBC48A22C8BBB900B30167 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5EFBC48622C8BBB900B30167 /* Main.storyboard */; };
		5EFBC48B22C8BBB900B30167 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5EFBC48822C8BBB900B30167 /* LaunchScreen.storyboard */; };
		5EFBC48F22C8BC2000B30167 /* TablesViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5EFBC48E22C8BC2000B30167 /* TablesViewController.swift */; };
		5EFBC49122C8C02600B30167 /* CrudOperationsViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5EFBC49022C8C02600B30167 /* CrudOperationsViewController.swift */; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		5E1DBE2B22CA6FED0005ED9F /* SortViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SortViewController.swift; sourceTree = "&lt;group&gt;"; };
		5E2D690622CA313400E63B09 /* PropertiesViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = PropertiesViewController.swift; sourceTree = "&lt;group&gt;"; };
		5E2D690822CA376B00E63B09 /* ObjectsViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ObjectsViewController.swift; sourceTree = "&lt;group&gt;"; };
		5E45D8CB22C8CF42005099F0 /* CodeSampleViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = CodeSampleViewController.swift; sourceTree = "&lt;group&gt;"; };
		5E45D8CD22C8CF61005099F0 /* RetrieveViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = RetrieveViewController.swift; sourceTree = "&lt;group&gt;"; };
		5E45D8CF22C8D15E005099F0 /* Utils.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Utils.swift; sourceTree = "&lt;group&gt;"; };
		5E6296CB22CB406A00D9B91F /* RelatedViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = RelatedViewController.swift; sourceTree = "&lt;group&gt;"; };
		5E6296CE22CB4DF600D9B91F /* ObjectsWithRelationsViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ObjectsWithRelationsViewController.swift; sourceTree = "&lt;group&gt;"; };
		5EFBC46E22C8BAF500B30167 /* <xsl:value-of select="$applicationName"/>-CRUD.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = <xsl:value-of select="$applicationName"/>-CRUD.app; sourceTree = BUILT_PRODUCTS_DIR; };
		5EFBC47122C8BAF500B30167 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "&lt;group&gt;"; };
		5EFBC47822C8BAF600B30167 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
		5EFBC47D22C8BAF600B30167 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
		5EFBC48722C8BBB900B30167 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "&lt;group&gt;"; };
		5EFBC48922C8BBB900B30167 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
		5EFBC48E22C8BC2000B30167 /* TablesViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TablesViewController.swift; sourceTree = "&lt;group&gt;"; };
		5EFBC49022C8C02600B30167 /* CrudOperationsViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = CrudOperationsViewController.swift; sourceTree = "&lt;group&gt;"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		5EFBC46B22C8BAF500B30167 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		5EFBC46522C8BAF500B30167 = {
			isa = PBXGroup;
			children = (
				5EFBC47022C8BAF500B30167 /* <xsl:value-of select="$applicationName"/>-CRUD */,
				5EFBC46F22C8BAF500B30167 /* Products */,
			);
			sourceTree = "&lt;group&gt;";
		};
		5EFBC46F22C8BAF500B30167 /* Products */ = {
			isa = PBXGroup;
			children = (
				5EFBC46E22C8BAF500B30167 /* <xsl:value-of select="$applicationName"/>-CRUD.app */,
			);
			name = Products;
			sourceTree = "&lt;group&gt;";
		};
		5EFBC47022C8BAF500B30167 /* <xsl:value-of select="$applicationName"/>-CRUD */ = {
			isa = PBXGroup;
			children = (
				5EFBC47122C8BAF500B30167 /* AppDelegate.swift */,
				5EFBC48C22C8BBFD00B30167 /* ViewControllers */,
				5EFBC48D22C8BC0600B30167 /* Utils */,
				5EFBC48622C8BBB900B30167 /* Main.storyboard */,
				5EFBC48822C8BBB900B30167 /* LaunchScreen.storyboard */,
				5EFBC47D22C8BAF600B30167 /* Info.plist */,
				5EFBC47822C8BAF600B30167 /* Assets.xcassets */,
			);
			path = <xsl:value-of select="$applicationName"/>-CRUD;
			sourceTree = "&lt;group&gt;";
		};
		5EFBC48C22C8BBFD00B30167 /* ViewControllers */ = {
			isa = PBXGroup;
			children = (
				5EFBC48E22C8BC2000B30167 /* TablesViewController.swift */,
				5EFBC49022C8C02600B30167 /* CrudOperationsViewController.swift */,
				5E45D8CB22C8CF42005099F0 /* CodeSampleViewController.swift */,
				5E45D8CD22C8CF61005099F0 /* RetrieveViewController.swift */,
				5E2D690622CA313400E63B09 /* PropertiesViewController.swift */,
				5E2D690822CA376B00E63B09 /* ObjectsViewController.swift */,
				5E1DBE2B22CA6FED0005ED9F /* SortViewController.swift */,
				5E6296CB22CB406A00D9B91F /* RelatedViewController.swift */,
				5E6296CE22CB4DF600D9B91F /* ObjectsWithRelationsViewController.swift */,
			);
			path = ViewControllers;
			sourceTree = "&lt;group&gt;";
		};
		5EFBC48D22C8BC0600B30167 /* Utils */ = {
			isa = PBXGroup;
			children = (
				5E45D8CF22C8D15E005099F0 /* Utils.swift */,
			);
			path = Utils;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		5EFBC46D22C8BAF500B30167 /* <xsl:value-of select="$applicationName"/>-CRUD */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 5EFBC48022C8BAF600B30167 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-CRUD" */;
			buildPhases = (
				5EFBC46A22C8BAF500B30167 /* Sources */,
				5EFBC46B22C8BAF500B30167 /* Frameworks */,
				5EFBC46C22C8BAF500B30167 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = <xsl:value-of select="$applicationName"/>-CRUD;
			productName = <xsl:value-of select="$applicationName"/>-CRUD;
			productReference = 5EFBC46E22C8BAF500B30167 /* <xsl:value-of select="$applicationName"/>-CRUD.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		5EFBC46622C8BAF500B30167 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				LastSwiftUpdateCheck = 1020;
				LastUpgradeCheck = 1020;
				TargetAttributes = {
					5EFBC46D22C8BAF500B30167 = {
						CreatedOnToolsVersion = 10.2.1;
					};
				};
			};
			buildConfigurationList = 5EFBC46922C8BAF500B30167 /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-CRUD" */;
			compatibilityVersion = "Xcode 9.3";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = 5EFBC46522C8BAF500B30167;
			productRefGroup = 5EFBC46F22C8BAF500B30167 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				5EFBC46D22C8BAF500B30167 /* <xsl:value-of select="$applicationName"/>-CRUD */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		5EFBC46C22C8BAF500B30167 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5EFBC48B22C8BBB900B30167 /* LaunchScreen.storyboard in Resources */,
				5EFBC47922C8BAF600B30167 /* Assets.xcassets in Resources */,
				5EFBC48A22C8BBB900B30167 /* Main.storyboard in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		5EFBC46A22C8BAF500B30167 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5EFBC49122C8C02600B30167 /* CrudOperationsViewController.swift in Sources */,
				5E45D8CE22C8CF61005099F0 /* RetrieveViewController.swift in Sources */,
				5E6296CF22CB4DF600D9B91F /* ObjectsWithRelationsViewController.swift in Sources */,
				5E6296CC22CB406A00D9B91F /* RelatedViewController.swift in Sources */,
				5E1DBE2C22CA6FED0005ED9F /* SortViewController.swift in Sources */,
				5E45D8CC22C8CF42005099F0 /* CodeSampleViewController.swift in Sources */,
				5E2D690722CA313400E63B09 /* PropertiesViewController.swift in Sources */,
				5EFBC47222C8BAF500B30167 /* AppDelegate.swift in Sources */,
				5EFBC48F22C8BC2000B30167 /* TablesViewController.swift in Sources */,
				5E45D8D022C8D15E005099F0 /* Utils.swift in Sources */,
				5E2D690922CA376B00E63B09 /* ObjectsViewController.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXVariantGroup section */
		5EFBC48622C8BBB900B30167 /* Main.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5EFBC48722C8BBB900B30167 /* Base */,
			);
			name = Main.storyboard;
			sourceTree = "&lt;group&gt;";
		};
		5EFBC48822C8BBB900B30167 /* LaunchScreen.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5EFBC48922C8BBB900B30167 /* Base */,
			);
			name = LaunchScreen.storyboard;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
		5EFBC47E22C8BAF600B30167 /* Debug */ = {
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
				IPHONEOS_DEPLOYMENT_TARGET = 12.2;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				MTL_FAST_MATH = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
			};
			name = Debug;
		};
		5EFBC47F22C8BAF600B30167 /* Release */ = {
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
				IPHONEOS_DEPLOYMENT_TARGET = 12.2;
				MTL_ENABLE_DEBUG_INFO = NO;
				MTL_FAST_MATH = YES;
				SDKROOT = iphoneos;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		5EFBC48122C8BAF600B30167 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CODE_SIGN_STYLE = Automatic;
				DEVELOPMENT_TEAM = 73FSJC7BUF;
				INFOPLIST_FILE = <xsl:value-of select="$applicationName"/>-CRUD/Info.plist;
				IPHONEOS_DEPLOYMENT_TARGET = 9.0;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				PRODUCT_BUNDLE_IDENTIFIER = com.backendless.<xsl:value-of select="$applicationName"/>-CRUD;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		5EFBC48222C8BAF600B30167 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CODE_SIGN_STYLE = Automatic;
				DEVELOPMENT_TEAM = 73FSJC7BUF;
				INFOPLIST_FILE = <xsl:value-of select="$applicationName"/>-CRUD/Info.plist;
				IPHONEOS_DEPLOYMENT_TARGET = 9.0;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				PRODUCT_BUNDLE_IDENTIFIER = com.backendless.<xsl:value-of select="$applicationName"/>-CRUD;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		5EFBC46922C8BAF500B30167 /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-CRUD" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5EFBC47E22C8BAF600B30167 /* Debug */,
				5EFBC47F22C8BAF600B30167 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		5EFBC48022C8BAF600B30167 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-CRUD" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5EFBC48122C8BAF600B30167 /* Debug */,
				5EFBC48222C8BAF600B30167 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = 5EFBC46622C8BAF500B30167 /* Project object */;
}
          </file>
        </folder>
      </folder>
    </xsl:template>
</xsl:stylesheet>