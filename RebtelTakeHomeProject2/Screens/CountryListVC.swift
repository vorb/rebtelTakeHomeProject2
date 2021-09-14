//
//  ViewController.swift
//  RebtelTakeHomeProject2
//
//  Created by Sebastian Mendez on 2021-09-13.
//

import UIKit

class CountryListVC: DataLoadingVC {
    
    private var searchController = UISearchController()
    private var collectionView: UICollectionView!
    private var countries: [Country] = []
    private var filteredCountries: [Country] = []
    private var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Countries"
        definesPresentationContext = true
        
        setupCollectionView()
        getCountries()
        configureSearchController()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: CountryCell.reuseID)
        
        collectionView.backgroundColor = .clear
    }
    
    func getCountries() {
        showLoadingView()
        
        NetworkManager.shared.getCountries { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let countries):
                self.countries = countries
                self.updateCollectionView()
            case .failure(let error):
                self.presentError(error)
            }
        }
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for country"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
    }
    
    private func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
    
extension CountryListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredCountries.count : countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCell.reuseID, for: indexPath) as! CountryCell
        
        cell.set(country: isSearching ? filteredCountries[indexPath.item] : countries[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CountryDetailsVC(country: isSearching ? filteredCountries[indexPath.item] : countries[indexPath.item])
        vc.modalPresentationStyle = .overCurrentContext
        
        searchController.isActive ? searchController.present(vc, animated: true) : self.present(vc, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension CountryListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else { return }
        
        isSearching = !searchString.isEmpty
         
        filteredCountries = countries.filter({ (country) -> Bool in
            let countryText: NSString = country.name as NSString
        
            return (countryText.range(of: searchString, options:NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })

        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        collectionView.reloadData()
    }
     
     
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        collectionView.reloadData()
    }
}
