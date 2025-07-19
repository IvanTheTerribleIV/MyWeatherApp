import Foundation
import UIKit

protocol LocationRowUI: AnyObject {
    func reload()
}

final class LocationsListTableViewCell: UITableViewCell {
    private var presenter: LocationsListRowPresenterProtocol?
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let locationNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minMaxTempLablel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        addSubviews()
        addContraints()
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(locationNameLabel)
        containerView.addSubview(iconImageView)
        containerView.addSubview(minMaxTempLablel)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            locationNameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            locationNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            minMaxTempLablel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            minMaxTempLablel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    func configure(model: LocationsListRowPresenterProtocol) {
        locationNameLabel.text = model.name
        self.presenter = model
        self.presenter?.ui = self
        presenter?.getWeatherData()
    }

}


extension LocationsListTableViewCell: LocationRowUI {
    func reload() {
        locationNameLabel.text = presenter?.name
        minMaxTempLablel.text = presenter?.minmaxTempTitle
        
    }
}
