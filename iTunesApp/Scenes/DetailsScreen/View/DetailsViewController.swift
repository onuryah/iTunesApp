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
    var viewModel: ImageSetter?
    
    let detailsImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImage()
        setImage()
    }
    
    func setImage() {
        viewModel?.setImage(view: detailsImage, urlString: selected)
    }
    
    func addImage() {
        detailsImage.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        detailsImage.contentMode = .scaleAspectFit
        view.addSubview(detailsImage)
    }
}
