
#import "SortViewController.h"
#import "CodeSampleViewController.h"
#import "Utils.h"

#define FIND_SORT @"Find with sort"
#define SHOW_SAMPLE @"ShowCodeSampleFromSortBy"

@interface SortViewController() {
    NSMutableArray<NSString *> *sortBy;
}
@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    sortBy = [NSMutableArray<NSString *> new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SortCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.fields objectAtIndex:indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CodeSampleViewController *codeSampleVC = [segue destinationViewController];
    codeSampleVC.tableName = self.tableName;
    codeSampleVC.operation = FIND_SORT;
    codeSampleVC.sortBy = sortBy;
}

- (IBAction)next:(id)sender {
    if (sortBy.count > 0) {
        [self performSegueWithIdentifier:SHOW_SAMPLE sender:nil];
    }
    else {
        Fault *fault = [[Fault alloc] initWithMessage:@"Please select fields to sort by" faultCode:0];
        [utils showErrorAlert:self fault:fault];
    }
}

- (IBAction)selectProperty:(id)sender {
    if ([[[sender superview] superview] isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSString *property = [self.fields objectAtIndex:indexPath.row];
        if ([(UISwitch *)sender isOn]) {
            [sortBy addObject:property];
        }
        else {
            [sortBy removeObject:property];
        }
    }
}

@end
