import UIKit

final class LocationsListViewController: UIViewController {
    private lazy var locationsView: LocationsListView = {
        LocationsListView(tableViewDelegate: self)
    }()
    private var presenter: LocationsListPresenterProtocol

    init(_ presenter: LocationsListPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.ui = self.locationsView
        
        title = presenter.screenTitle()
        presenter.getLocations()
    }
}

extension LocationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presenter = LocationsListPresenter()
        let LocationsListViewController = LocationsListViewController(presenter)
        LocationsListViewController.presenter = presenter
        
        navigationController?.pushViewController(LocationsListViewController, animated: true)
    }
}

