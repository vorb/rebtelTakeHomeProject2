//
//  ItalicLabel.swift
//  RebtelTakeHomeProject2
//
//  Created by Sebastian Mendez on 2021-09-14.
//

import UIKit

class SecondaryLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(textAlignment: NSTextAlignment = .left, textColor: UIColor = .gray, fontSize: CGFloat, numberOfLines: Int = 0) {
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
        self.font = UIFont.italicSystemFont(ofSize: fontSize)
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
