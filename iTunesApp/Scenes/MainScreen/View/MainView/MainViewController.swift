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
    
    
    fileprivate func setup() {
        searchBarAdded()
        let initilazer = MainViewModel(networkManager: NetworkManager())
        viewModel = initilazer
        setCollectionView()
    }


}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
}

extension MainViewController : UISearchResultsUpdating {
    
}

