import UIKit

final class LocationsListViewController: UIViewController {
    var mainView: LocationsListView { return view as! LocationsListView  }
    
    var presenter: LocationsListPresenterProtocol?
    var locationsListProvider: LocationsListAdapter?
    
    override func loadView() {
        view = LocationsListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationsListProvider = LocationsListAdapter(tableView: mainView.heroesTableView)
        
        presenter?.ui = self
        
        title = presenter?.screenTitle()
        
        mainView.heroesTableView.delegate = self
        presenter?.getLocations()
    }
}

extension LocationsListViewController: LocationsListUI {
    func update(locations: [LocationModel]) {
        locationsListProvider?.locations = locations
    }
}

extension LocationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presenter = LocationsListPresenter()
        let LocationsListViewController = LocationsListViewController()
        LocationsListViewController.presenter = presenter
        
        navigationController?.pushViewController(LocationsListViewController, animated: true)
    }
}

