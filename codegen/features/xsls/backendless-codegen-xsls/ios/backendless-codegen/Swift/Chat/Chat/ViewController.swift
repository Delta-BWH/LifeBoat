

import UIKit
import Backendless

class ViewController: UIViewController {
    
    @IBOutlet var userNameTextField: UITextField!
    
    var userName: String?
    var channel: Channel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func showErrorAlert(_ fault: Fault) {
        let alert = UIAlertController(title: String(format: "Error %@", fault.faultCode), message: fault.message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismissButton)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowChat") {
            let chatVC = segue.destination as! ChatViewController
            chatVC.userName = userName
            chatVC.channel = channel
        }
    }
    
    @IBAction func pressedStartChat(_ sender: Any) {
        if (!(userNameTextField.text?.isEmpty)!) {
            userName = userNameTextField.text
            channel = Backendless.shared.messaging.subscribe(channelName: "realtime_example")
            let _ = channel?.addConnectListener(responseHandler: {
                self.performSegue(withIdentifier: "ShowChat", sender: nil)
            }, errorHandler: { fault in
                self.showErrorAlert(fault)
            })
        }
        else {
            showErrorAlert(Fault(message: "Please enter user name", faultCode: 0))
        }        
    }
}

