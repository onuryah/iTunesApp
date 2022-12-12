//
//  MainViewModel.swift
//  iTunesApp
//
//  Created by admin on 12.12.2022.
//

import UIKit


protocol MainViewModelProtocol {
    var delegate: MainViewModelDelegate? { get set }
    
    func load(query: String)
}

protocol MainViewModelDelegate: AnyObject {
    func reloadData()
}
final class MainViewModel  {
    weak var delegate: MainViewModelDelegate?
    let networkManager: NetworkManager<MainEndpointItem>
    private var upComingMediaList: [String] = []
    
    private var upComingMediaList1 : [String] = []
    private var upComingMediaList2 : [String] = []
    private var upComingMediaList3 : [String] = []
    private var upComingMediaList4 : [String] = []

    
    enum MainConstants {
        static let defaultQueryStr: String = "all"
        static let threadCount: Int = 3
    }
    
    init(networkManager: NetworkManager<MainEndpointItem>) {
        self.networkManager = networkManager
    }


    
    
    private func fetchUpComingDataList(query: String = MainConstants.defaultQueryStr){
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
    func load(query: String) {
        fetchUpComingDataList(query: query)
    }
    
    func downloadImage(from url: String) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let datakb = self.logImageSizeInKB(data: data)
            if datakb < 100 {
                self.upComingMediaList1.append(url)
            }else if datakb < 250 {
                self.upComingMediaList2.append(url)
            }else if datakb < 500 {
                self.upComingMediaList3.append(url)
            }else if datakb > 500 {
                self.upComingMediaList4.append(url)
                print(url)
            }
            self.delegate?.reloadData()
        }
    }
    
    func getData(from url: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let ad = URL(string: url) else {return}
        URLSession.shared.dataTask(with: ad, completionHandler: completion).resume()
    }
    
    func logImageSizeInKB(data: Data) -> (Int) {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useKB
        formatter.countStyle = ByteCountFormatter.CountStyle.file
        return (Int(Int64(data.count) / 1024))
    }


}
