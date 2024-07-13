import UIKit

protocol EngineersListOrdering {
    
    var currentOrderType: EngineerOrderType? { get }
    func orderEngineers(by order: EngineerOrderType)
}

class EngineersTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    private lazy var viewModel = EngineersTableViewModel(engineers: Engineer.testingData(), delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Engineers at Glucode"
        tableView.backgroundColor = .white
        registerCells()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
        tableView.reloadData()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Order by",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(orderByTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    @objc func orderByTapped() {
        guard let from = navigationItem.rightBarButtonItem else { return }
        let controller = OrderByTableViewController(style: .plain)
        let size = CGSize(width: 200, height: 150)
        present(popover: controller,
                from: from,
                size: size,
                arrowDirection: .up)
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, 
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

    private func registerCells() {
        tableView.register(UINib(nibName: String(describing: GlucodianTableViewCell.self), bundle: nil), 
                           forCellReuseIdentifier: String(describing: GlucodianTableViewCell.self))
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEngineers
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GlucodianTableViewCell.self)) as? GlucodianTableViewCell
        guard let cell, let engineerInfo = viewModel.displayInfo(forEngineerAt: indexPath.row) else { return UITableViewCell() }
        cell.setUp(with: engineerInfo)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let engineer = viewModel.engineer(at: indexPath.row) else { return }
        let controller = QuestionsViewController.loadController(with: engineer)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - EngineersTableViewModelDelegate

extension EngineersTableViewController: EngineersTableViewModelDelegate {
    
    func updateList() {
        tableView.reloadData()
    }
}

// MARK: - EngineersListOrdering

extension EngineersTableViewController: EngineersListOrdering {
    
    var currentOrderType: EngineerOrderType? { viewModel.currentOrderType }
    
    func orderEngineers(by order: EngineerOrderType) {
        viewModel.orderEngineers(by: order)
    }
}
