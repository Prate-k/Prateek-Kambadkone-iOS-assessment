import UIKit

enum EngineerOrderType: String, CaseIterable {
    
    case years = "Years"
    case coffees = "Coffees"
    case bugs = "Bugs"
}

class OrderByTableViewController: UITableViewController {
    
    private let orderTypes = EngineerOrderType.allCases
    
    var delegate: EngineersListOrdering? {
        return self.popoverPresentationController?.delegate as? EngineersListOrdering
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let text = orderTypes.value(at: indexPath.row)?.rawValue,
              let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self)) else { return UITableViewCell() }
        cell.textLabel?.text = text
        cell.accessoryType = delegate?.currentOrderType?.rawValue == text ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        deselectPreviousSelection(tableView)
        if let orderType = orderTypes.value(at: indexPath.row),
           let delegate = delegate {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
            }
            delegate.orderEngineers(by: orderType)
        }
    }
    
    private func deselectPreviousSelection(_ tableView: UITableView) {
        guard let previousOrder = delegate?.currentOrderType,
              let index = orderTypes.firstIndex(of: previousOrder) else { return }
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}
