//
//  DetailsViewModel.swift
//  iTunesApp
//
//  Created by admin on 12.12.2022.
//

import Foundation
import SDWebImage

protocol ImageSetter {
    func setImage(view: UIImageView, urlString: String)
}

class DetailsViewModel: ImageSetter {
    func setImage(view: UIImageView, urlString: String) {
        guard let url = URL(string: urlString) else {return}
        view.sd_setImage(with: url)
    }
}
