//
//  CountryCell.swift
//  RebtelTakeHomeProject2
//
//  Created by Sebastian Mendez on 2021-09-13.
//

import UIKit

class CountryCell: UICollectionViewCell {
    static let reuseID = "CountryCell"
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let countryNameLabel = PrimaryLabel(textAlignment: .center, fontSize: 16, numberOfLines: 2)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        flagImageView.makeRounded()
    }
    
    public func set(country: Country) {
        countryNameLabel.text = country.name
        countryNameLabel.adjustsFontSizeToFitWidth = true
        countryNameLabel.lineBreakMode = .byTruncatingTail
        countryNameLabel.minimumScaleFactor = 0.9
        
        flagImageView.image = UIImage(named: country.alpha2Code.lowercased())
    }
    
    private func configure() {
        addSubview(flagImageView)
        addSubview(countryNameLabel)
        
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            flagImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            flagImageView.heightAnchor.constraint(equalTo: flagImageView.widthAnchor),
            
            countryNameLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 12),
            countryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            countryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            countryNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
