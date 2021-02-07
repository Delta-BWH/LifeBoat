
import UIKit

class CrudOperationsViewController: UITableViewController {
    
    var tableName: String!
    
    private let CREATE = "Create"
    private let RETRIEVE = "Retrieve"
    private let UPDATE = "Update"
    private let DELETE = "Delete"

    private let SHOW_SAMPLE = "ShowCodeSample"
    private let SHOW_RETRIEVE = "ShowRetrieve"

    private var operations = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        operations = [CREATE, RETRIEVE, UPDATE, DELETE]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrudOperationCell", for: indexPath)
        cell.textLabel?.text = operations[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let operation = operations[indexPath.row]
        if operation == RETRIEVE {
            performSegue(withIdentifier: SHOW_RETRIEVE, sender: nil)
        }
        else {
            performSegue(withIdentifier: SHOW_SAMPLE, sender: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SHOW_RETRIEVE {
            if let retrieveVC = segue.destination as? RetrieveViewController {
                retrieveVC.tableName = tableName
            }
        }
        else {
            if let codeSampleVC = segue.destination as? CodeSampleViewController,
                let indexPath = sender as? IndexPath {
                codeSampleVC.tableName = tableName
                codeSampleVC.operation = operations[indexPath.row]
            }
        }
    }
}
