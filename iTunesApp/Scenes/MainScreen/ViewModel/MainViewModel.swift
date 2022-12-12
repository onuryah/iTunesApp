//
//  MainViewModel.swift
//  iTunesApp
//
//  Created by admin on 12.12.2022.
//

import UIKit


protocol MainViewModelProtocol {
    var delegate: MainViewModelDelegate? { get set }
}

protocol MainViewModelDelegate: AnyObject {
    func reloadData()
}
final class MainViewModel  {
    weak var delegate: MainViewModelDelegate?
    private var upComingMediaList: [String] = []
}

extension MainViewModel : MainViewModelProtocol {
    
}
