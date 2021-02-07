
#import "CodeSampleViewController.h"
#import "ProperiesViewController.h"
#import "ObjectsWithRelationsViewController.h"
#import <Backendless-Swift.h>
#import "Utils.h"

#define CREATE @"Create"
#define UPDATE @"Update"
#define DELETE @"Delete"

#define BASIC_FIND @"Basic find"
#define FIND_FIRST @"Find first"
#define FIND_LAST @"Find last"
#define FIND_SORT @"Find with sort"
#define FIND_RELATED @"Find with related"

#define SHOW_PROPERTIES @"ShowTableProperties"
#define SHOW_OBJECTS_WITH_RELATIONS @"ShowObjectsWithRelations"

@interface CodeSampleViewController() {
    MapDrivenDataStore *dataStore;
}
@end

@implementation CodeSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareCodeSample];
    dataStore = [Backendless.shared.data ofTable:self.tableName];
}

- (void)prepareCodeSample {
    if ([self.operation isEqualToString:CREATE]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.textView.text = [utils createStringForTableName:self.tableName];
        });
    }
    else if ([self.operation isEqualToString:UPDATE]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.textView.text = [utils updateStringForTableName:self.tableName];
        });
    }
    else if ([self.operation isEqualToString:DELETE]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.textView.text = [utils deleteStringForTableName:self.tableName];
        });
    }
    else if ([self.operation isEqualToString:BASIC_FIND]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.textView.text = [utils basicFindStringForTableName:self.tableName];
        });
    }
    else if ([self.operation isEqualToString:FIND_FIRST]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.textView.text = [utils firstFindStringForTableName:self.tableName];
        });
    }
    else if ([self.operation isEqualToString:FIND_LAST]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.textView.text = [utils lastFindStringForTableName:self.tableName];
        });
    }
    else if ([self.operation isEqualToString:FIND_SORT]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.textView.text = [utils sortFindSringForTableName:self.tableName sortBy:self.sortBy];
        });
    }
    else if ([self.operation isEqualToString:FIND_RELATED]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.textView.text = [utils relatedFindSringForTableName:self.tableName related:self.related];
        });
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SHOW_PROPERTIES]) {
        ProperiesViewController *propertiesVC = [segue destinationViewController];
        propertiesVC.tableName = self.tableName;
        propertiesVC.operation = self.operation;
        if ([propertiesVC.operation isEqualToString:FIND_SORT]) {
            propertiesVC.sortBy = self.sortBy;
        }
        [Backendless.shared.data describeWithTableName:self.tableName responseHandler:^(NSArray *properties) {
            NSMutableDictionary<NSString *, NSString *> *fields = [NSMutableDictionary<NSString *, NSString *> new];
            for (ObjectProperty *property in properties) {
                if (![[property getTypeName] isEqualToString:@"RELATION"] &&
                    ![[property getTypeName] isEqualToString:@"RELATION_LIST"]) {
                     [fields setObject:[property getTypeName] forKey:property.name];
                }
            }
            propertiesVC.fields = fields;
            [propertiesVC.tableView reloadData];
        } errorHandler:^(Fault *fault) {
            [utils showErrorAlert:self fault:fault];
        }];
    }
    else if ([segue.identifier isEqualToString:SHOW_OBJECTS_WITH_RELATIONS]) {
        ObjectsWithRelationsViewController *objectsWithRelsVC = [segue destinationViewController];
        objectsWithRelsVC.related = self.related;
        objectsWithRelsVC.tableName = self.tableName;
        [dataStore findWithResponseHandler:^(NSArray *foundObjects) {
            NSMutableArray<NSString *> *objectIds = [NSMutableArray<NSString *> new];
            for (NSDictionary *foundObject in foundObjects) {
                [objectIds addObject: [foundObject objectForKey:@"objectId"]];
            }
            [Backendless.shared.data describeWithTableName:self.tableName responseHandler:^(NSArray *properties) {
                for (ObjectProperty *property in properties) {
                    if ([[property getTypeName] isEqualToString:@"RELATION"] ||
                        [[property getTypeName] isEqualToString:@"RELATION_LIST"]) {
                        objectsWithRelsVC.relatedTableName = property.relatedTable;
                        objectsWithRelsVC.propertyType = [property getTypeName];
                        objectsWithRelsVC.objectIds = objectIds;
                        [objectsWithRelsVC.tableView reloadData];
                    }
                }
            } errorHandler:^(Fault *fault) {
                [utils showErrorAlert:self fault:fault];
            }];
        } errorHandler:^(Fault *fault) {
            [utils showErrorAlert:self fault:fault];
        }];
    }
}

- (IBAction)runCode:(id)sender {
    if ([self.operation isEqualToString:CREATE]) {
        NSDictionary *newObject = @{@"codegen": @"new object"};
        [dataStore saveWithEntity:newObject responseHandler:^(NSDictionary *savedObject) {
            NSString *objectId = [savedObject objectForKey:@"objectId"];
            utils.currentObjectId = objectId;
            [utils showCreatedAlert:self objectId:objectId];
        } errorHandler:^(Fault *fault) {
            [utils showErrorAlert:self fault:fault];
        }];
    }
    else if ([self.operation isEqualToString:UPDATE]) {
        NSString *objectId = utils.currentObjectId;
        if (objectId) {
            NSDictionary *object = @{@"codegen": @"updated object", @"objectId": objectId};
            [dataStore updateWithEntity:object responseHandler:^(NSDictionary *updatedObject) {
                [utils showUpdatedAlert:self objectId:objectId];
            } errorHandler:^(Fault *fault) {
                [utils showErrorAlert:self fault:fault];
            }];
        }
        else {
            Fault *fault = [[Fault alloc] initWithMessage:@"Please create object before updating" faultCode:0];
            [utils showErrorAlert:self fault:fault];
        }
    }
    else if ([self.operation isEqualToString:DELETE]) {
        NSString *objectId = utils.currentObjectId;
        if (objectId) {
            [dataStore removeByIdWithObjectId:objectId responseHandler:^(NSInteger removed) {
                [utils showDeletedAlert:self objectId:objectId];
                utils.currentObjectId = nil;
            } errorHandler:^(Fault *fault) {
                [utils showErrorAlert:self fault:fault];
            }];
        }
        else {
            Fault *fault = [[Fault alloc] initWithMessage:@"Please create object before deleting" faultCode:0];
            [utils showErrorAlert:self fault:fault];
        }
    }
    else if ([self.operation isEqualToString:FIND_RELATED]) {
        [self performSegueWithIdentifier:SHOW_OBJECTS_WITH_RELATIONS sender:nil];
    }
    else {
        [self performSegueWithIdentifier:SHOW_PROPERTIES sender:nil];
    }
}

- (IBAction)sendCodeByEmail:(id)sender {
    [utils showSendByEmailAlert:self message:[utils createMessageForEmail:self.operation codeSample:self.textView.text]];
}

@end
