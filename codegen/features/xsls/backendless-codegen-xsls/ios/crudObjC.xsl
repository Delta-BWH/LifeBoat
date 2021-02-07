 <xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
    <!-- @formatter:off -->

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/IOS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>
    <xsl:variable name="tables" select="backendless-codegen/application/tables"/>
    <xsl:variable name="tableNames" select="backendless-codegen/application/tables/name"/>
    <xsl:variable name="usersTableId" select="backendless-codegen/application/tables/table[name = 'Users']/tableId"/>

    <xsl:template name="crudObjC">
      <folder  hideContent="true"    name="{$applicationName}-CRUD">
        <file  hideContent="true"    path="backendless-codegen/ObjC/CRUD/README.txt"/>
          
        <file name="Podfile">

target '<xsl:value-of select="$applicationName"/>-CRUD' do

use_frameworks!
pod 'BackendlessSwift'

end
        </file>
        
        <folder  hideContent="true"    name="{$applicationName}-CRUD">
          <folder  hideContent="true"    path="backendless-codegen/ObjC/CRUD/CRUD/Base.lproj"/>
          <folder  hideContent="true"    path="backendless-codegen/ObjC/CRUD/CRUD/Assets.xcassets"/>
          <folder  hideContent="true"    path="backendless-codegen/ObjC/CRUD/CRUD/Utils"/>
          <folder  hideContent="true"    path="backendless-codegen/ObjC/CRUD/CRUD/ViewControllers"/>
          <file  hideContent="true"    path="backendless-codegen/ObjC/CRUD/CRUD/AppDelegate.h"/>
          <file  hideContent="true"    path="backendless-codegen/ObjC/CRUD/CRUD/Info.plist"/>
          <file  hideContent="true"    path="backendless-codegen/ObjC/CRUD/CRUD/main.m"/>
          
          <file  hideContent="true"    name="AppDelegate.m">
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

          <folder  hideContent="true"    name="ViewControllers">
            <file  hideContent="true"    name="TablesViewController.m">
#import "TablesViewController.h"
#import "CrudOperationsViewController.h"
#import &lt;Backendless-Swift.h&gt;

#define SHOW_CRUD @"ShowCrudOperations"

@interface TablesViewController() {
    NSArray&lt;NSString *&gt; *tableNames;
}
@end

@implementation TablesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getTables];
}

- (void)getTables {
    NSString *tables = @"<xsl:for-each select="$tables/table[name != 'Users']"><xsl:value-of select="name"/>, </xsl:for-each>";
    tableNames = [tables componentsSeparatedByString:@", "];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableNameCell" forIndexPath:indexPath];
    cell.textLabel.text = [tableNames objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:SHOW_CRUD sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CrudOperationsViewController *crudOperationsVC = [segue destinationViewController];
    crudOperationsVC.tableName = [tableNames objectAtIndex:((NSIndexPath *)sender).row];
}

@end
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
		5E50DE7E22C247200075C76F /* CodeSampleViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5E50DE7D22C247200075C76F /* CodeSampleViewController.m */; };
		5E521B0122C50B8E00A09DDF /* SortViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5E521B0022C50B8E00A09DDF /* SortViewController.m */; };
		5EA4295A22C22ADE0058182C /* AppDelegate.m in Sources */ = {isa = PBXBuildFile; fileRef = 5EA4295922C22ADE0058182C /* AppDelegate.m */; };
		5EA4296022C22ADE0058182C /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5EA4295E22C22ADE0058182C /* Main.storyboard */; };
		5EA4296222C22ADF0058182C /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 5EA4296122C22ADF0058182C /* Assets.xcassets */; };
		5EA4296822C22ADF0058182C /* main.m in Sources */ = {isa = PBXBuildFile; fileRef = 5EA4296722C22ADF0058182C /* main.m */; };
		5EA4297322C22C6D0058182C /* TablesViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5EA4297222C22C6D0058182C /* TablesViewController.m */; };
		5EA4297622C22E640058182C /* CrudOperationsViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5EA4297522C22E640058182C /* CrudOperationsViewController.m */; };
		5ED5657A22C5285E006997F2 /* RelatedViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5ED5657922C5285E006997F2 /* RelatedViewController.m */; };
		5ED5657D22C53348006997F2 /* ObjectsWithRelationsViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5ED5657C22C53348006997F2 /* ObjectsWithRelationsViewController.m */; };
		5EE1A17722C3B03A00674DC3 /* ProperiesViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5EE1A17622C3B03A00674DC3 /* ProperiesViewController.m */; };
		5EE52E0C22C364D800EB1A29 /* Utils.m in Sources */ = {isa = PBXBuildFile; fileRef = 5EE52E0B22C364D800EB1A29 /* Utils.m */; };
		5EE52E1222C3889200EB1A29 /* RetrieveViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5EE52E1122C3889200EB1A29 /* RetrieveViewController.m */; };
		5EE8C5E522C3BAF700297A84 /* ObjectsViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5EE8C5E422C3BAF700297A84 /* ObjectsViewController.m */; };
		5EFBC48522C8BB8200B30167 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5EFBC48322C8BB8200B30167 /* LaunchScreen.storyboard */; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		5E50DE7C22C247200075C76F /* CodeSampleViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = CodeSampleViewController.h; sourceTree = "&lt;group&gt;"; };
		5E50DE7D22C247200075C76F /* CodeSampleViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = CodeSampleViewController.m; sourceTree = "&lt;group&gt;"; };
		5E521AFF22C50B8E00A09DDF /* SortViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = SortViewController.h; sourceTree = "&lt;group&gt;"; };
		5E521B0022C50B8E00A09DDF /* SortViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = SortViewController.m; sourceTree = "&lt;group&gt;"; };
		5EA4295522C22ADE0058182C /* <xsl:value-of select="$applicationName"/>-CRUD.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = <xsl:value-of select="$applicationName"/>-CRUD.app; sourceTree = BUILT_PRODUCTS_DIR; };
		5EA4295822C22ADE0058182C /* AppDelegate.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = AppDelegate.h; sourceTree = "&lt;group&gt;"; };
		5EA4295922C22ADE0058182C /* AppDelegate.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = AppDelegate.m; sourceTree = "&lt;group&gt;"; };
		5EA4295F22C22ADE0058182C /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "&lt;group&gt;"; };
		5EA4296122C22ADF0058182C /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
		5EA4296622C22ADF0058182C /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
		5EA4296722C22ADF0058182C /* main.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = main.m; sourceTree = "&lt;group&gt;"; };
		5EA4297122C22C6D0058182C /* TablesViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = TablesViewController.h; sourceTree = "&lt;group&gt;"; };
		5EA4297222C22C6D0058182C /* TablesViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = TablesViewController.m; sourceTree = "&lt;group&gt;"; };
		5EA4297422C22E640058182C /* CrudOperationsViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = CrudOperationsViewController.h; sourceTree = "&lt;group&gt;"; };
		5EA4297522C22E640058182C /* CrudOperationsViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = CrudOperationsViewController.m; sourceTree = "&lt;group&gt;"; };
		5ED5657822C5285E006997F2 /* RelatedViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = RelatedViewController.h; sourceTree = "&lt;group&gt;"; };
		5ED5657922C5285E006997F2 /* RelatedViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = RelatedViewController.m; sourceTree = "&lt;group&gt;"; };
		5ED5657B22C53348006997F2 /* ObjectsWithRelationsViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = ObjectsWithRelationsViewController.h; sourceTree = "&lt;group&gt;"; };
		5ED5657C22C53348006997F2 /* ObjectsWithRelationsViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = ObjectsWithRelationsViewController.m; sourceTree = "&lt;group&gt;"; };
		5EE1A17522C3B03A00674DC3 /* ProperiesViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = ProperiesViewController.h; sourceTree = "&lt;group&gt;"; };
		5EE1A17622C3B03A00674DC3 /* ProperiesViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = ProperiesViewController.m; sourceTree = "&lt;group&gt;"; };
		5EE52E0A22C364D800EB1A29 /* Utils.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = Utils.h; sourceTree = "&lt;group&gt;"; };
		5EE52E0B22C364D800EB1A29 /* Utils.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = Utils.m; sourceTree = "&lt;group&gt;"; };
		5EE52E1022C3889200EB1A29 /* RetrieveViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = RetrieveViewController.h; sourceTree = "&lt;group&gt;"; };
		5EE52E1122C3889200EB1A29 /* RetrieveViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = RetrieveViewController.m; sourceTree = "&lt;group&gt;"; };
		5EE8C5E322C3BAF700297A84 /* ObjectsViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = ObjectsViewController.h; sourceTree = "&lt;group&gt;"; };
		5EE8C5E422C3BAF700297A84 /* ObjectsViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = ObjectsViewController.m; sourceTree = "&lt;group&gt;"; };
		5EFBC48422C8BB8200B30167 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		5EA4295222C22ADE0058182C /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		5EA4294C22C22ADE0058182C = {
			isa = PBXGroup;
			children = (
				5EA4295722C22ADE0058182C /* <xsl:value-of select="$applicationName"/>-CRUD */,
				5EA4295622C22ADE0058182C /* Products */,
			);
			sourceTree = "&lt;group&gt;";
		};
		5EA4295622C22ADE0058182C /* Products */ = {
			isa = PBXGroup;
			children = (
				5EA4295522C22ADE0058182C /* <xsl:value-of select="$applicationName"/>-CRUD.app */,
			);
			name = Products;
			sourceTree = "&lt;group&gt;";
		};
		5EA4295722C22ADE0058182C /* <xsl:value-of select="$applicationName"/>-CRUD */ = {
			isa = PBXGroup;
			children = (
				5EFBC48322C8BB8200B30167 /* LaunchScreen.storyboard */,
				5EA4295822C22ADE0058182C /* AppDelegate.h */,
				5EA4295922C22ADE0058182C /* AppDelegate.m */,
				5EA4296722C22ADF0058182C /* main.m */,
				5EE52E0822C3649E00EB1A29 /* ViewControllers */,
				5EE52E0922C364AF00EB1A29 /* Utils */,
				5EA4296622C22ADF0058182C /* Info.plist */,
				5EA4295E22C22ADE0058182C /* Main.storyboard */,
				5EA4296122C22ADF0058182C /* Assets.xcassets */,
			);
			path = <xsl:value-of select="$applicationName"/>-CRUD;
			sourceTree = "&lt;group&gt;";
		};
		5EE52E0822C3649E00EB1A29 /* ViewControllers */ = {
			isa = PBXGroup;
			children = (
				5EA4297122C22C6D0058182C /* TablesViewController.h */,
				5EA4297222C22C6D0058182C /* TablesViewController.m */,
				5EA4297422C22E640058182C /* CrudOperationsViewController.h */,
				5EA4297522C22E640058182C /* CrudOperationsViewController.m */,
				5E50DE7C22C247200075C76F /* CodeSampleViewController.h */,
				5E50DE7D22C247200075C76F /* CodeSampleViewController.m */,
				5EE52E1022C3889200EB1A29 /* RetrieveViewController.h */,
				5EE52E1122C3889200EB1A29 /* RetrieveViewController.m */,
				5EE1A17522C3B03A00674DC3 /* ProperiesViewController.h */,
				5EE1A17622C3B03A00674DC3 /* ProperiesViewController.m */,
				5EE8C5E322C3BAF700297A84 /* ObjectsViewController.h */,
				5EE8C5E422C3BAF700297A84 /* ObjectsViewController.m */,
				5E521AFF22C50B8E00A09DDF /* SortViewController.h */,
				5E521B0022C50B8E00A09DDF /* SortViewController.m */,
				5ED5657822C5285E006997F2 /* RelatedViewController.h */,
				5ED5657922C5285E006997F2 /* RelatedViewController.m */,
				5ED5657B22C53348006997F2 /* ObjectsWithRelationsViewController.h */,
				5ED5657C22C53348006997F2 /* ObjectsWithRelationsViewController.m */,
			);
			path = ViewControllers;
			sourceTree = "&lt;group&gt;";
		};
		5EE52E0922C364AF00EB1A29 /* Utils */ = {
			isa = PBXGroup;
			children = (
				5EE52E0A22C364D800EB1A29 /* Utils.h */,
				5EE52E0B22C364D800EB1A29 /* Utils.m */,
			);
			path = Utils;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		5EA4295422C22ADE0058182C /* <xsl:value-of select="$applicationName"/>-CRUD */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 5EA4296B22C22ADF0058182C /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-CRUD" */;
			buildPhases = (
				5EA4295122C22ADE0058182C /* Sources */,
				5EA4295222C22ADE0058182C /* Frameworks */,
				5EA4295322C22ADE0058182C /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = <xsl:value-of select="$applicationName"/>-CRUD;
			productName = <xsl:value-of select="$applicationName"/>-CRUD;
			productReference = 5EA4295522C22ADE0058182C /* <xsl:value-of select="$applicationName"/>-CRUD.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		5EA4294D22C22ADE0058182C /* Project object */ = {
			isa = PBXProject;
			attributes = {
				LastUpgradeCheck = 1020;
				ORGANIZATIONNAME = "Olha Danylova";
				TargetAttributes = {
					5EA4295422C22ADE0058182C = {
						CreatedOnToolsVersion = 10.2.1;
					};
				};
			};
			buildConfigurationList = 5EA4295022C22ADE0058182C /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-CRUD" */;
			compatibilityVersion = "Xcode 9.3";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = 5EA4294C22C22ADE0058182C;
			productRefGroup = 5EA4295622C22ADE0058182C /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				5EA4295422C22ADE0058182C /* <xsl:value-of select="$applicationName"/>-CRUD */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		5EA4295322C22ADE0058182C /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5EFBC48522C8BB8200B30167 /* LaunchScreen.storyboard in Resources */,
				5EA4296222C22ADF0058182C /* Assets.xcassets in Resources */,
				5EA4296022C22ADE0058182C /* Main.storyboard in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		5EA4295122C22ADE0058182C /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5EE8C5E522C3BAF700297A84 /* ObjectsViewController.m in Sources */,
				5ED5657D22C53348006997F2 /* ObjectsWithRelationsViewController.m in Sources */,
				5EA4297322C22C6D0058182C /* TablesViewController.m in Sources */,
				5E521B0122C50B8E00A09DDF /* SortViewController.m in Sources */,
				5EA4296822C22ADF0058182C /* main.m in Sources */,
				5EA4297622C22E640058182C /* CrudOperationsViewController.m in Sources */,
				5ED5657A22C5285E006997F2 /* RelatedViewController.m in Sources */,
				5EE52E0C22C364D800EB1A29 /* Utils.m in Sources */,
				5EE1A17722C3B03A00674DC3 /* ProperiesViewController.m in Sources */,
				5EE52E1222C3889200EB1A29 /* RetrieveViewController.m in Sources */,
				5E50DE7E22C247200075C76F /* CodeSampleViewController.m in Sources */,
				5EA4295A22C22ADE0058182C /* AppDelegate.m in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXVariantGroup section */
		5EA4295E22C22ADE0058182C /* Main.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5EA4295F22C22ADE0058182C /* Base */,
			);
			name = Main.storyboard;
			sourceTree = "&lt;group&gt;";
		};
		5EFBC48322C8BB8200B30167 /* LaunchScreen.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5EFBC48422C8BB8200B30167 /* Base */,
			);
			name = LaunchScreen.storyboard;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
		5EA4296922C22ADF0058182C /* Debug */ = {
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
			};
			name = Debug;
		};
		5EA4296A22C22ADF0058182C /* Release */ = {
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
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		5EA4296C22C22ADF0058182C /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CODE_SIGN_STYLE = Automatic;
				INFOPLIST_FILE = <xsl:value-of select="$applicationName"/>-CRUD/Info.plist;
				IPHONEOS_DEPLOYMENT_TARGET = 9.0;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				PRODUCT_BUNDLE_IDENTIFIER = com.backendless.<xsl:value-of select="$applicationName"/>-CRUD;
				PRODUCT_NAME = "$(TARGET_NAME)";
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		5EA4296D22C22ADF0058182C /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CODE_SIGN_STYLE = Automatic;
				INFOPLIST_FILE = <xsl:value-of select="$applicationName"/>-CRUD/Info.plist;
				IPHONEOS_DEPLOYMENT_TARGET = 9.0;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				PRODUCT_BUNDLE_IDENTIFIER = com.backendless.<xsl:value-of select="$applicationName"/>-CRUD;
				PRODUCT_NAME = "$(TARGET_NAME)";
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		5EA4295022C22ADE0058182C /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-CRUD" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5EA4296922C22ADF0058182C /* Debug */,
				5EA4296A22C22ADF0058182C /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		5EA4296B22C22ADF0058182C /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-CRUD" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5EA4296C22C22ADF0058182C /* Debug */,
				5EA4296D22C22ADF0058182C /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = 5EA4294D22C22ADE0058182C /* Project object */;
}
          </file>
        </folder>
      </folder>
    </xsl:template>
</xsl:stylesheet>