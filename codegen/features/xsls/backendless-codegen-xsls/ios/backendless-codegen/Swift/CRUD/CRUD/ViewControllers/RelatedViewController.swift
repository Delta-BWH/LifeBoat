
import UIKit
import Backendless

class RelatedViewController: UITableViewController {
    
    var tableName = ""
    var fields = [String]()
    
    private let FIND_RELATED = "Find with related"
    private let SHOW_SAMPLE = "ShowCodeSampleFromRelated"
    
    private let utils = Utils.shared
    
    private var related = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedCell", for: indexPath)
        cell.textLabel?.text = fields[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let codeSampleVC = segue.destination as? CodeSampleViewController {
            codeSampleVC.tableName = tableName
            codeSampleVC.operation = FIND_RELATED
            codeSampleVC.related = related.first
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if related.count != 1 {
            let fault = Fault(message: "Please select only one related field to load its objects", faultCode: 0)
            utils.showErrorAler(target: self, fault: fault)
        }
        else {
            performSegue(withIdentifier: SHOW_SAMPLE, sender: nil)
        }
    }
    
    @IBAction func selectProperty(_ sender: Any) {
        if let sender = sender as? UISwitch,
            let cell = sender.superview?.superview as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            let property = fields[indexPath.row]
            if sender.isOn {
                related.append(property)
            }
            else if let index = related.firstIndex(of: property) {
                related.remove(at: index)
            }
        }
    }
}
