
#import "ObjectsViewController.h"
#import "Utils.h"

@implementation ObjectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ / %@", self.tableName, self.propertyName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ObjectCell" forIndexPath:indexPath];
    cell.textLabel.text = [utils cellTitle:[self.objects objectAtIndex:indexPath.row] type:self.type];    
    return cell;
}

@end
