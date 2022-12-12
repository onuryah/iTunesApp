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
    let networkManager: NetworkManager<MainEndpointItem>
    private var upComingMediaList: [String] = []
    
    enum MainConstants {
        static let defaultQueryStr: String = "all"
        static let threadCount: Int = 3
    }
    
    init(networkManager: NetworkManager<MainEndpointItem>) {
        self.networkManager = networkManager
    }


    
    
    private func fetchUpComingMovieList(query: String = MainConstants.defaultQueryStr){
        networkManager.request(endpoint: .upcoming(query: query), type: MediaResponse.self) { result in
            let queue = OperationQueue()
            queue.maxConcurrentOperationCount = MainConstants.threadCount
            let blockOperation = BlockOperation {
                switch result {
                case .success(let response):
                    let movieList = response.results
                    let medias = movieList.compactMap{ $0 }
                    medias.forEach({ media in
                        media.screenshotUrls.forEach { string in
                        }
                    })
                    break
                case .failure(let error):
                    print(String(describing: error))
                    break
                }
            }
            queue.addOperation(blockOperation)
        }
    }

}

extension MainViewModel : MainViewModelProtocol {
    func downloadImage(from url: String) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            self.delegate?.reloadData()
        }
    }
    
    func getData(from url: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let ad = URL(string: url) else {return}
        URLSession.shared.dataTask(with: ad, completionHandler: completion).resume()
    }
    


}
