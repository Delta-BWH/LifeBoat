
import UIKit

class ObjectsViewController: UITableViewController {
    
    var tableName: String = ""
    var propertyName: String = ""
    var type: String = ""
    var objects = [Any]()
    
    private let utils = Utils.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(tableName) / \(propertyName)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectCell", for: indexPath)
        cell.textLabel?.text = utils.cellTitle(value: objects[indexPath.row], type: type)
        return cell
    }
}
