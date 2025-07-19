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
        
        presenter.ui = view as? LocationsListUI
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        title = presenter.screenTitle()
        presenter.getLocations()
    }
}

extension LocationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectLocation(at: indexPath)
    }
}
