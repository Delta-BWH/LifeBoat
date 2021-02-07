
#import "CrudOperationsViewController.h"
#import "CodeSampleViewController.h"
#import "RetrieveViewController.h"

#define CREATE @"Create"
#define RETRIEVE @"Retrieve"
#define UPDATE @"Update"
#define DELETE @"Delete"

#define SHOW_SAMPLE @"ShowCodeSample"
#define SHOW_RETRIEVE @"ShowRetrieve"

@interface CrudOperationsViewController() {
    NSArray<NSString *> *operations;
}
@end

@implementation CrudOperationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    operations = @[CREATE, RETRIEVE, UPDATE, DELETE];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return operations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CrudOperationCell" forIndexPath:indexPath];
    cell.textLabel.text = [operations objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *operation = [operations objectAtIndex:indexPath.row];
    if ([operation isEqualToString:RETRIEVE]) {
        [self performSegueWithIdentifier:SHOW_RETRIEVE sender:nil];
    }
    else {
        [self performSegueWithIdentifier:SHOW_SAMPLE sender:indexPath];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:SHOW_RETRIEVE]) {
        RetrieveViewController *retrieveVC = [segue destinationViewController];
        retrieveVC.tableName = self.tableName;
    }
    else {
        CodeSampleViewController *codeSampleVC = [segue destinationViewController];
        codeSampleVC.tableName = self.tableName;
        codeSampleVC.operation = [operations objectAtIndex:((NSIndexPath *)sender).row];
    }
}

@end
