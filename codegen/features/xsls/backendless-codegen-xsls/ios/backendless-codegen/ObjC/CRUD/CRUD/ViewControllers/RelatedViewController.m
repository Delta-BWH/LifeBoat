
#import "RelatedViewController.h"
#import "CodeSampleViewController.h"
#import "Utils.h"
#import <Backendless-Swift.h>

#define FIND_RELATED @"Find with related"
#define SHOW_SAMPLE @"ShowCodeSampleFromRelated"

@interface RelatedViewController() {
    NSMutableArray<NSString *> *related;
}
@end

@implementation RelatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    related = [NSMutableArray<NSString *> new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RelatedCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.fields objectAtIndex:indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CodeSampleViewController *codeSampleVC = [segue destinationViewController];
    codeSampleVC.tableName = self.tableName;
    codeSampleVC.operation = FIND_RELATED;
    codeSampleVC.related = related.firstObject;
}

- (IBAction)next:(id)sender {
    if (related.count != 1) {
        Fault *fault = [[Fault alloc] initWithMessage:@"Please select only one related field to load its objects" faultCode:0];
        [utils showErrorAlert:self fault:fault];
    }
    else {
        [self performSegueWithIdentifier:SHOW_SAMPLE sender:nil];
    }
}

- (IBAction)selectProperty:(id)sender {
    if ([[[sender superview] superview] isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSString *property = [self.fields objectAtIndex:indexPath.row];
        if ([(UISwitch *)sender isOn]) {
            [related addObject:property];
        }
        else {
            [related removeObject:property];
        }
    }
}

@end
