//
//  ViewController.swift
//  iTunesApp
//
//  Created by admin on 12.12.2022.
//

import UIKit

class MainViewController: UIViewController, MainViewModelDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dataCheckView: UIView!
    let searchController = UISearchController()
    
    var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.load(query: "all")
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func setup() {
        searchBarAdded()
        let initilazer = MainViewModel(networkManager: NetworkManager())
        viewModel = initilazer
        setCollectionView()
    }


}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.giveTitlesOfSections(view: dataCheckView).count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.giveCombined()[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingTableViewCell", for: indexPath) as! UpcomingCollectionViewCell
        viewModel.configureUpComingTableViewCell(cell, forIndexPath: indexPath)
        return cell
    }
    
    fileprivate func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.calculateCellHeight(collectionView: collectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSection = viewModel.giveCombined()[indexPath.section]
        let selectedItem = selectedSection[indexPath.item]
        viewModel.pushToDetails(selectedImageString: selectedItem, viewController: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
        sectionHeaderView.categoryTitle = viewModel.giveTitlesOfSections(view: dataCheckView)[indexPath.section]
        return sectionHeaderView
    }

}

extension MainViewController : UISearchResultsUpdating {
    fileprivate func searchBarAdded(){
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.updateSearch(searchBar: searchController, view: dataCheckView)
    }
}

