
import UIKit
import Backendless

class ChatViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var chatTextView: UITextView!
    @IBOutlet var messageTextField: UITextField!
    
    var userName: String!
    var channel: Channel!
    var activeTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = userName
        chatTextView.delegate = self
        messageTextField.delegate = self
        addMessageListener()
        publishMessage(String(format: "%@ joined", userName!))
        navigationItem.hidesBackButton = true
        navigationItem.backBarButtonItem = nil
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chatTextView.scrollRangeToVisible(NSRange(location: chatTextView.text.count - 1, length: 1))
    }
    
    func addMessageListener() {
        let _ = channel.addStringMessageListener(responseHandler: { message in
            if (!self.chatTextView.text.isEmpty) {
                self.chatTextView.insertText(String(format: "\n\n%@", message))
            }
            else {
                self.chatTextView.insertText(String(format: "%@", message))
            }
        }, errorHandler: { fault in
            self.showErrorAlert(fault)
        })
    }
    
    func publishMessage(_ message: String) {
        Backendless.shared.messaging.publish(channelName: channel.channelName, message: message, responseHandler: { messageStatus in
        }, errorHandler: { fault in
            self.showErrorAlert(fault)
        })
    }
    
    @objc func keyboardDidShow(_ notification: NSNotification) {
        let infoValue = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardSize = infoValue.cgRectValue.size
        UIView.animate(withDuration: 0.3, animations: {
            var viewFrame = self.view.frame
            viewFrame.size.height -= keyboardSize.height
            self.view.frame = viewFrame
        })
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.3, animations: {
            let screenFrame = UIScreen.main.bounds
            var viewFrame = CGRect(x: 0, y: 0, width: screenFrame.size.width, height: screenFrame.size.height)
            viewFrame.origin.y = 0
            self.view.frame = viewFrame
        })
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (!(messageTextField.text?.isEmpty)!) {
            publishMessage(String(format: "[%@]: %@", userName!, messageTextField.text!))
            messageTextField.text = ""
        }
        textField.resignFirstResponder()
        return true
    }
    
    func showErrorAlert(_ fault: Fault) {
        let alert = UIAlertController(title: String(format: "Error %@", fault.faultCode), message: fault.message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismissButton)
        present(alert, animated: true, completion: nil)
    }
}
