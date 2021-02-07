
#import "ViewController.h"
#import "ChatViewController.h"
#import <Backendless/Backendless-Swift.h>

@interface ViewController() {
    NSString *userName;
    Channel *channel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)showErrorAlert:(Fault *)fault {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Error %li", fault.faultCode] message:fault.message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissButton = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:dismissButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowChat"]) {
        ChatViewController *chatVC = [segue destinationViewController];
        chatVC.userName = userName;
        chatVC.channel = channel;
    }
}

- (IBAction)pressedStartChat:(id)sender {
    __weak ViewController *weakSelf = self;
    if ([self.userNameTextField.text length] > 0) {
        userName = self.userNameTextField.text;
        channel = [Backendless.shared.messaging subscribeWithChannelName:@"realtime_example"];
        RTSubscription *subscription __unused = [channel addConnectListenerWithResponseHandler:^{
            [weakSelf performSegueWithIdentifier:@"ShowChat" sender:nil];
        } errorHandler:^(Fault *fault) {
            [weakSelf showErrorAlert:fault];
        }];
    }
    else {
        [self showErrorAlert:[[Fault alloc] initWithMessage:@"Please enter user name" faultCode:0]];
    }
}

@end
         		
