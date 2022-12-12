//
//  DetailsViewController.swift
//  iTunesApp
//
//  Created by admin on 12.12.2022.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    var selected = String()
    
    let detailsImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsImage.sd_setImage(with: URL(string: selected))
    }
}
