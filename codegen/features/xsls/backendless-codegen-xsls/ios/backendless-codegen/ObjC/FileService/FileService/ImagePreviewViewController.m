#import "ImagePreviewViewController.h"
#import "BrowseViewController.h"
#import "FileObject.h"
#import <Backendless-Swift.h>

@interface ImagePreviewViewController() {
    DataStoreFactory *filesDataStore;
}
@end

@implementation ImagePreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareView];
    filesDataStore = [Backendless.shared.data of:[FileObject class]];
}

- (void)prepareView {
    self.mainImageView.image = self.mainImage;
    if (self.isUpload) {
        [self.navigationItem setTitle:@"Uploaded photo"];
        [self.uploadBtn setTitle:@"Remove"];
    }
    else {
        [self.navigationItem setTitle:@"Upload photo"];
        [self.uploadBtn setTitle:@"Upload"];
    }
}

- (void)saveEntityWithName:(NSString *)path {
    self.file = [FileObject new];
    self.file.path = path;
    [filesDataStore saveWithEntity:self.file responseHandler:^(FileObject *savedFile) {
    } errorHandler:^(Fault *fault) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

- (IBAction)pressedUpload:(id)sender {
    if (self.isUpload) {
        [Backendless.shared.file removeWithPath:[NSString stringWithFormat:@"img/%@", [[self.file.path pathComponents] lastObject]] responseHandler:^{
            [self->filesDataStore removeWithEntity:self.file responseHandler:^(NSInteger removed) {
                self.file = nil;
                [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Image has been deleted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                [self.navigationController popToRootViewControllerAnimated:YES];
            } errorHandler:^(Fault *fault) {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }];
        } errorHandler:^(Fault *fault) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }];
    }
    else {
        [Backendless.shared.file uploadFileWithFileName:[NSString stringWithFormat:@"%0.0f.jpeg", [[NSDate date] timeIntervalSince1970]] filePath:@"img" content:UIImageJPEGRepresentation(self.mainImage, 0.1) responseHandler:^(BackendlessFile *uploadedFile) {
            [self saveEntityWithName:uploadedFile.fileUrl];
        } errorHandler:^(Fault *fault) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }];
    }
    self.isUpload = !self.isUpload;
    [self prepareView];
    if(self.isUpload) {
        [[[UIAlertView alloc] initWithTitle:@"Image uploaded" message:@"The Image has been uploaded. The file is available in the files browser" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
