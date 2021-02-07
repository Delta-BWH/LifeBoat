
#import "RetrieveViewController.h"
#import "CodeSampleViewController.h"
#import "SortViewController.h"
#import "RelatedViewController.h"
#import "Utils.h"

#define BASIC_FIND @"Basic find"
#define FIND_FIRST @"Find first"
#define FIND_LAST @"Find last"
#define FIND_SORT @"Find with sort"
#define FIND_RELATED @"Find with related"

#define SHOW_SAMPLE @"ShowCodeSampleFromRetrieve"
#define SHOW_SORT @"ShowSortBy"
#define SHOW_RELATED @"ShowRelated"

@interface RetrieveViewController() {
    NSArray<NSString *> *retrieveTypes;
    NSArray<NSString *> *sortBy;
}
@end

@implementation RetrieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    retrieveTypes = @[BASIC_FIND, FIND_FIRST, FIND_LAST, FIND_SORT, FIND_RELATED];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return retrieveTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RetrieveTypeCell" forIndexPath:indexPath];
    cell.textLabel.text = [retrieveTypes objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[retrieveTypes objectAtIndex:indexPath.row] isEqualToString:FIND_SORT]) {
        [self performSegueWithIdentifier:SHOW_SORT sender:nil];
    }
    else if ([[retrieveTypes objectAtIndex:indexPath.row] isEqualToString:FIND_RELATED]) {
        [self performSegueWithIdentifier:SHOW_RELATED sender:nil];
    }
    else {
        [self performSegueWithIdentifier:SHOW_SAMPLE sender:indexPath];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:SHOW_SORT]) {
        SortViewController *sortVC = [segue destinationViewController];
        sortVC.tableName = self.tableName;
        [Backendless.shared.data describeWithTableName:self.tableName responseHandler:^(NSArray *properties) {
            NSMutableArray<NSString *> *fields = [NSMutableArray<NSString *> new];
            for (ObjectProperty *property in properties) {
                if (![[property getTypeName] isEqualToString:@"RELATION"] &&
                    ![[property getTypeName] isEqualToString:@"RELATION_LIST"]) {
                    [fields addObject:property.name];
                }
            }
            sortVC.fields = fields;
            [sortVC.tableView reloadData];
        } errorHandler:^(Fault *fault) {
            [utils showErrorAlert:self fault:fault];
        }];
    }
    else if ([[segue identifier] isEqualToString:SHOW_RELATED]) {
        RelatedViewController *relatedVC = [segue destinationViewController];
        relatedVC.tableName = self.tableName;
        [Backendless.shared.data describeWithTableName:self.tableName responseHandler:^(NSArray *properties) {
            NSMutableArray<NSString *> *fields = [NSMutableArray<NSString *> new];
            for (ObjectProperty *property in properties) {
                if ([[property getTypeName] isEqualToString:@"RELATION"] ||
                    [[property getTypeName] isEqualToString:@"RELATION_LIST"]) {
                    [fields addObject:property.name];
                }
            }
            relatedVC.fields = fields;
            [relatedVC.tableView reloadData];
        } errorHandler:^(Fault *fault) {
            [utils showErrorAlert:self fault:fault];
        }];
    }
    else if ([[segue identifier] isEqualToString:SHOW_SAMPLE]) {
        CodeSampleViewController *codeSampleVC = [segue destinationViewController];
        codeSampleVC.tableName = self.tableName;
        codeSampleVC.operation = [retrieveTypes objectAtIndex:((NSIndexPath *)sender).row];
    }
}

@end
