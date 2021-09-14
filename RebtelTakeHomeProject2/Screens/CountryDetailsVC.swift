//
//  CountryDetailsVC.swift
//  RebtelTakeHomeProject2
//
//  Created by Sebastian Mendez on 2021-09-14.
//

import UIKit

class CountryDetailsVC: UIViewController {
    var country: Country!
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var languagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var countryNameLabel = PrimaryLabel(textAlignment: .left, fontSize: 20, numberOfLines: 1)
    private var capitalNameLabel = PrimaryLabel(textAlignment: .left, fontSize: 16, numberOfLines: 1)
    
    convenience init(country: Country) {
        self.init()
        self.country = country
        
        setCountryInfo()
        layoutUI()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseIn], animations: {
            self.view.backgroundColor = CustomColors.dimmedViewBackground
            self.containerView.alpha = 1
            self.containerView.transform = CGAffineTransform.identity
        }, completion: nil)
        
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        tapToDismiss.delegate = self
        view.addGestureRecognizer(tapToDismiss)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCountryInfo() {
        flagImageView.image = UIImage(named: country.alpha2Code.lowercased())
        countryNameLabel.text = country.name
        capitalNameLabel.text = "Capital: \(country.capital)"
    }
    
    private func layoutUI() {
        view.backgroundColor = .clear
        
        view.addSubview(containerView)
        containerView.addSubview(flagImageView)
        containerView.addSubview(countryNameLabel)
        containerView.addSubview(capitalNameLabel)
        containerView.addSubview(infoStackView)
        containerView.addSubview(languagesStackView)
        
        infoStackView.addArrangedSubview(CountryInfoView(title: "Region", body: country.region))
        infoStackView.addArrangedSubview(CountryInfoView(title: "Area", body: String(country.area ?? 0)))
        infoStackView.addArrangedSubview(CountryInfoView(title: "Population", body: String(country.population)))
        
        setupLanguageStackview()
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 460),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            
            flagImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            flagImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            flagImageView.heightAnchor.constraint(equalToConstant: 160),
            
            countryNameLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 20),
            countryNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            capitalNameLabel.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 20),
            capitalNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: capitalNameLabel.bottomAnchor, constant: 8),
            infoStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            infoStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            infoStackView.heightAnchor.constraint(equalToConstant: 40),
            
            languagesStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 36),
            languagesStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    private func setupLanguageStackview() {
        if !country.languages.isEmpty {
            let titleLabel = PrimaryLabel(textAlignment: .center, fontSize: 16, numberOfLines: 1)
            titleLabel.text = "Languages:"
            
            languagesStackView.addArrangedSubview(titleLabel)
            
            for language in country.languages {
                let bodyLabel = SecondaryLabel(textAlignment: .center, fontSize: 14, numberOfLines: 1)
                bodyLabel.text = language.name
                
                languagesStackView.addArrangedSubview(bodyLabel)
            }
        }
    }
    
    @objc func dismissViewController() {        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseIn], animations: {
            self.containerView.alpha = 0
            self.containerView.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            self.view.backgroundColor = .clear
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
}

extension CountryDetailsVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view != self.view {
            return false
        }
        return true
    }
}
