#import "ChatViewController.h"

@interface ChatViewController() {
    UITextField *activeTextField;
}
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.userName;
    self.chatTextView.delegate = self;
    self.messageTextField.delegate = self;
    [self addMessageListener];
    [self publishMessage:[NSString stringWithFormat:@"%@ joined", self.userName]];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem setBackBarButtonItem:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.chatTextView scrollRangeToVisible:NSMakeRange([self.chatTextView.text length] - 1, 1)];
}

- (void)addMessageListener {
    __weak ChatViewController *weakSelf = self;
    RTSubscription *subscription __unused = [self.channel addStringMessageListenerWithResponseHandler:^(NSString *message) {
        if ([self.chatTextView.text length] > 0) {
            [weakSelf.chatTextView insertText:[NSString stringWithFormat:@"\n\n%@", message]];
        }
        else {
            [weakSelf.chatTextView insertText:[NSString stringWithFormat:@"%@", message]];
        }
    } errorHandler:^(Fault *fault) {
        [weakSelf showErrorAlert:fault];
    }];
}

- (void)publishMessage:(NSString *)message {
    [Backendless.shared.messaging publishWithChannelName:self.channel.channelName message:message responseHandler:^(MessageStatus *messageStatus) {
    } errorHandler:^(Fault *fault) {
        [self showErrorAlert:fault];
    }];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    NSValue *infoValue = [notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = infoValue.CGRectValue.size;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect viewFrame = self.view.frame;
        viewFrame.size.height -= keyboardSize.height;
        self.view.frame = viewFrame;
    }];
}

-(void)keyboardWillBeHidden:(NSNotification *)notification {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect screenFrame = [[UIScreen mainScreen] bounds];
        CGRect viewFrame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height);
        viewFrame.origin.y = 0;
        self.view.frame = viewFrame;
    }];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    activeTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.messageTextField.text length] > 0) {
        [self publishMessage:[NSString stringWithFormat:@"[%@]: %@", self.userName, self.messageTextField.text]];
        self.messageTextField.text = @"";
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)showErrorAlert:(Fault *)fault {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Error %li", fault.faultCode] message:fault.message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissButton = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:dismissButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
