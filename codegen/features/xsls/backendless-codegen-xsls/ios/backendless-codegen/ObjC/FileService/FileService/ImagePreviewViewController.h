
#import <UIKit/UIKit.h>
#import "FileObject.h"

@interface ImagePreviewViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) FileObject *file;
@property (nonatomic, strong) UIImage *mainImage;
@property (nonatomic) BOOL isUpload;
@property (nonatomic, strong) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *uploadBtn;

- (IBAction)pressedUpload:(id)sender;

@end
