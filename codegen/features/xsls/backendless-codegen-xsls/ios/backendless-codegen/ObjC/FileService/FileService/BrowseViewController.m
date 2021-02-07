#import "BrowseViewController.h"
#import "ImagePreviewViewController.h"
#import "FileObject.h"
#import <Backendless-Swift.h>

@interface BrowseViewController () {
    NSArray *mainData;
    DataStoreFactory *filesDataStore;
}
@end

@implementation BrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    filesDataStore = [Backendless.shared.data of:[FileObject class]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getAllEntitysAsync];
}

- (void)getAllEntitysAsync {
    [filesDataStore findWithResponseHandler:^(NSArray *photos) {
        if (photos.count == 0) {
            [[[UIAlertView alloc] initWithTitle:@"No files found" message:@"Please take some photos before you can browse them" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else {
            self->mainData = photos;
            [self.mainTableView reloadData];
        }
    } errorHandler:^(Fault *fault) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (mainData.count / 4) + ((mainData.count % 4) ? 1 : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    for (int i = 1; i <= 4; i++) {
        if (indexPath.row * 4 + i > mainData.count)
            break;
        UIButton *button = (UIButton *)[cell viewWithTag:i];
        NSString *str = (NSString *)[[mainData objectAtIndex:indexPath.row * 4 + i - 1] path];
        NSURL *url = [NSURL URLWithString:str];
        button.hidden = NO;
        button.enabled = NO;
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            NSHTTPURLResponse *responseUrl = [(NSHTTPURLResponse *)response copy];
            NSInteger statusCode = [responseUrl  statusCode];
            if (statusCode == 200) {
                [button setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                button.enabled = YES;
            }
        }];
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    ImagePreviewViewController *imagePreview = (ImagePreviewViewController *)[segue destinationViewController];
    [imagePreview setMainImage:[(UIButton *)sender imageForState:UIControlStateNormal]];
    [imagePreview setIsUpload:YES];
    [imagePreview setFile:[mainData objectAtIndex:indexPath.row * 4 + [sender tag] - 1]];
}

- (IBAction)pressedRemoveAll:(id)sender {
    [Backendless.shared.file removeWithPath:@"img" responseHandler:^{
        for (FileObject *file in self->mainData) {
            [self->filesDataStore removeWithEntity:file responseHandler:^(NSInteger removed) {
                [[[UIAlertView alloc] initWithTitle:@"Files removed" message:@"All files have been removed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            } errorHandler:^(Fault *fault) {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }];
        }
    } errorHandler:^(Fault *fault) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
