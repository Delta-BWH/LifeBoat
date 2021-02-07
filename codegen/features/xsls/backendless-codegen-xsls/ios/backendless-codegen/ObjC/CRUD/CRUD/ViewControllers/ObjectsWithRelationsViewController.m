
#import "ObjectsWithRelationsViewController.h"
#import "ProperiesViewController.h"
#import "Utils.h"
#import <Backendless-Swift.h>

#define FIND_RELATED @"Find with related"
#define SHOW_PROPERTIES @"ShowRelatedProperties"

@implementation ObjectsWithRelationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objectIds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ObjectIdCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.objectIds objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:SHOW_PROPERTIES sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ProperiesViewController *propertiesVC = [segue destinationViewController];
    propertiesVC.operation = FIND_RELATED;
    propertiesVC.related = self.related;
    propertiesVC.objectId = [self.objectIds objectAtIndex:((NSIndexPath *)sender).row];
    propertiesVC.tableName = self.relatedTableName;
    
    [Backendless.shared.data describeWithTableName:self.relatedTableName responseHandler:^(NSArray *properties) {
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

@end
