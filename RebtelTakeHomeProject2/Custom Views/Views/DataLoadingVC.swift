//
//  DataLoadingVC.swift
//  RebtelTakeHomeProject2
//
//  Created by Sebastian Mendez on 2021-09-13.
//

import UIKit

class DataLoadingVC: UIViewController {
    
    private var containerView: UIView!
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView()
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func presentError(_ error: CustomError) {
        var errorText = ""
        
        switch error {
        case .invalidURL:
            errorText = "The data recieved from the error was invalid."
        case .invalidResponse:
            errorText = "Invalid response from error."
        case .invalidData:
            errorText = "There was an error connecting to the server."
        case .unableToComplete:
            errorText = "Unable to complete your request at this time. Please check your internet connection."
        }
        
        let dialogMessage = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
        let OkeyButton = UIAlertAction(title: "OK", style: .default)
        
        dialogMessage.addAction(OkeyButton)

        DispatchQueue.main.async {
            self.present(dialogMessage, animated: true, completion: nil)
        }
        
    }
}
