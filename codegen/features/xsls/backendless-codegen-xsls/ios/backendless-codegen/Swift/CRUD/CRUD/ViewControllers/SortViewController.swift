
import UIKit
import Backendless

class SortViewController: UITableViewController {
    
    var tableName = ""
    var fields = [String]()
    
    private var sortBy = [String]()
    
    private let FIND_SORT = "Find with sort"
    private let SHOW_SAMPLE = "ShowCodeSampleFromSortBy"
    private let utils = Utils.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath)
        cell.textLabel?.text = fields[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let codeSampleVC = segue.destination as? CodeSampleViewController {
            codeSampleVC.tableName = tableName
            codeSampleVC.operation = FIND_SORT
            codeSampleVC.sortBy = sortBy
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if sortBy.count > 0 {
            performSegue(withIdentifier: SHOW_SAMPLE, sender: nil)
        }
        else {
            let fault = Fault(message: "Please select fields to sort by", faultCode: 0)
            utils.showErrorAler(target: self, fault: fault)
        }
    }
    
    @IBAction func selectProperty(_ sender: Any) {
        if let sender = sender as? UISwitch,
            let cell = sender.superview?.superview as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            let property = fields[indexPath.row]
            if sender.isOn {
                sortBy.append(property)
            }
            else if let index = sortBy.firstIndex(of: property) {
                sortBy.remove(at: index)
            }
        }
    }
}
