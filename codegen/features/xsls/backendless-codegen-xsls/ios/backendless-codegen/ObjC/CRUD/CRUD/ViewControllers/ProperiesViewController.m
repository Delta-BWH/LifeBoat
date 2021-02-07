
#import "ProperiesViewController.h"
#import "ObjectsViewController.h"
#import "Utils.h"
#import <Backendless-Swift.h>

#define BASIC_FIND @"Basic find"
#define FIND_FIRST @"Find first"
#define FIND_LAST @"Find last"
#define FIND_SORT @"Find with sort"
#define FIND_RELATED @"Find with related"

#define SHOW_OBJECTS @"ShowObjects"

@interface ProperiesViewController() {
    MapDrivenDataStore *dataStore;
}
@end

@implementation ProperiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ properties", self.tableName];
    dataStore = [Backendless.shared.data ofTable:self.tableName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ObjectPropertyCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.fields allKeys] objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:SHOW_OBJECTS sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {    
    NSString *field = [[self.fields allKeys] objectAtIndex:((NSIndexPath *)sender).row];
    NSString *type = [self.fields objectForKey:field];
    
    ObjectsViewController *objectsVC = [segue destinationViewController];
    objectsVC.tableName = self.tableName;
    objectsVC.propertyName = field;
    objectsVC.type = type;
    
    if ([self.operation isEqualToString:BASIC_FIND] || [self.operation isEqualToString:FIND_RELATED]) {
        [dataStore findWithResponseHandler:^(NSArray *foundObjects) {
            NSMutableArray *objects = [NSMutableArray new];
            for (NSDictionary *foundObject in foundObjects) {
                if ([foundObject objectForKey:field]) {
                    [objects addObject:[foundObject objectForKey:field]];
                }
            }
            objectsVC.objects = objects;
            [objectsVC.tableView reloadData];
        } errorHandler:^(Fault *fault) {
            [utils showErrorAlert:self fault:fault];
        }];
    }
    else if ([self.operation isEqualToString:FIND_FIRST]) {
        [dataStore findFirstWithResponseHandler:^(NSDictionary *firstObject) {
            objectsVC.objects = @[[firstObject valueForKey:field]];
            [objectsVC.tableView reloadData];
        } errorHandler:^(Fault *fault) {
            [utils showErrorAlert:self fault:fault];
        }];
    }
    else if ([self.operation isEqualToString:FIND_LAST]) {
        [dataStore findLastWithResponseHandler:^(NSDictionary *lastObject) {
            objectsVC.objects = @[[lastObject valueForKey:field]];
            [objectsVC.tableView reloadData];
        } errorHandler:^(Fault *fault) {
            [utils showErrorAlert:self fault:fault];
        }];
    }
    else if ([self.operation isEqualToString:FIND_SORT]) {
        DataQueryBuilder *queryBuilder = [DataQueryBuilder new];
        [queryBuilder setSortBySortBy:self.sortBy];
        
        [dataStore findWithQueryBuilder:queryBuilder responseHandler:^(NSArray *sortedObjects) {
            NSMutableArray *objects = [NSMutableArray new];
            for (NSDictionary *object in sortedObjects) {
                [objects addObject:[object objectForKey:field]];
            }
            objectsVC.objects = objects;
            [objectsVC.tableView reloadData];
        } errorHandler:^(Fault *fault) {
            [utils showErrorAlert:self fault:fault];
        }];
    }
}

@end
