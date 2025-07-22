//
//  LocationRowContentView.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 21.07.2025.
//

import UIKit

final class LocationRowContentView: UIView {
    private var presenter: LocationsListRowPresenterProtocol?

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private let locationNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minMaxTempLablel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let conditionsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(locationNameLabel)
        addSubview(iconImageView)
        addSubview(minMaxTempLablel)
        addSubview(conditionsLabel)
        addSubview(currentTemperatureLabel)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            locationNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            locationNameLabel.trailingAnchor.constraint(equalTo: currentTemperatureLabel.leadingAnchor, constant: -12),
            locationNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            currentTemperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            currentTemperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            iconImageView.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor, constant: 12),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            
            conditionsLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            conditionsLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            
            minMaxTempLablel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            minMaxTempLablel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    func configure(presenter: LocationsListRowPresenterProtocol) {
        self.presenter = presenter
        reload()
    }
    
    func reload() {
        locationNameLabel.text = presenter?.name
        locationNameLabel.text = presenter?.name
        minMaxTempLablel.text = presenter?.minMaxTempTitle
        iconImageView.image = presenter?.icon
        currentTemperatureLabel.text = presenter?.currentTemperature
        conditionsLabel.text = presenter?.conditions
    }
}
