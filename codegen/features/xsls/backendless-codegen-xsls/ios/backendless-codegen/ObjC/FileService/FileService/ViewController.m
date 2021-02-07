
#import "ViewController.h"
#import "ImagePreviewViewController.h"
#import "FileObject.h"
#import <Backendless-Swift.h>

@interface ViewController() {
    BOOL isSimulator;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#if TARGET_IPHONE_SIMULATOR
    isSimulator = YES;
#else
    isSimulator = NO;
#endif
}

- (void)takePhoto:(id)sender {
    if (isSimulator) {
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Make sure to run the app on a device, the functionality is not available in a simulator" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    else {
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            picker.showsCameraControls = YES;
        }
        else {
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        [self presentViewController:picker animated:YES completion:nil];
    }    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        ImagePreviewViewController *imagePreviewVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"ImagePreviewViewController"];
        imagePreviewVC.mainImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self.navigationController pushViewController:imagePreviewVC animated:YES];
    }];
}

@end
          
