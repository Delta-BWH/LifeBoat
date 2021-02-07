
import UIKit
import Backendless

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {    
    
    var isSimulator: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if (arch(i386) || arch(x86_64))
        isSimulator = true
        #else
        isSimulator = false
        #endif
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: {
            let imagePreviewVC = self.storyboard?.instantiateViewController(withIdentifier: "ImagePreviewViewController") as! ImagePreviewViewController
            imagePreviewVC.mainImage = info[.originalImage] as? UIImage
            self.navigationController?.pushViewController(imagePreviewVC, animated: true)
        })
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        if isSimulator {
            UIAlertView.init(title: "Warning!", message: "Make sure to run the app on a device, the functionality is not available in a simulator", delegate: nil, cancelButtonTitle: "OK").show()
        }
        else {
            let picker = UIImagePickerController()
            picker.delegate = self
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                picker.sourceType = .camera
                picker.showsCameraControls = true
            }
            else {
                picker.sourceType = .photoLibrary
            }
            self.present(picker, animated: true, completion: nil)
        }
    }
}

