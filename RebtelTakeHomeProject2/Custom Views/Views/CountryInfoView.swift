//
//  CountryInfoView.swift
//  RebtelTakeHomeProject2
//
//  Created by Sebastian Mendez on 2021-09-14.
//

import UIKit

class CountryInfoView: UIView {
    private let title = PrimaryLabel(textAlignment: .center, fontSize: 14, numberOfLines: 1)
    private let body = SecondaryLabel(textAlignment: .center, fontSize: 13, numberOfLines: 1)
    
    convenience init(title: String, body: String) {
        self.init()
        
        self.title.text = title
        self.body.text = body
        
        layoutUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        addSubview(title)
        addSubview(body)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            body.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            body.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}
