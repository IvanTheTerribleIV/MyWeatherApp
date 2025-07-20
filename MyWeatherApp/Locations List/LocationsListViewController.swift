import UIKit

final class LocationsListViewController: UIViewController {
    private var presenter: LocationsListPresenterProtocol
    
    override func loadView() {
        view = LocationsListView(tableViewDelegate: self)
    }

    init(_ presenter: LocationsListPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        presenter.ui = view as? LocationsListUI
        
        presenter.getLocations()
    }
    
    private func configureUI() {
        let leftBarItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(settingsButtonPressed))
        navigationItem.leftBarButtonItem = leftBarItem
        
        let rightBarItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(addButtonPressed))
        
        navigationItem.rightBarButtonItem = rightBarItem
        
        title = presenter.screenTitle()
    }
    
    @objc private func settingsButtonPressed() {
        presenter.openSettings()
    }
    
    @objc private func addButtonPressed() {
        presenter.addNewLocation()
    }
}

extension LocationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectLocation(at: indexPath)
    }
}
