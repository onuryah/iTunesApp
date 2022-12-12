//
//  SectionHeaderView.swift
//  iTunesApp
//
//  Created by admin on 12.12.2022.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var categoryLabelField: UILabel!
    
    var categoryTitle: String! {
        didSet {
            categoryLabelField.text = categoryTitle
        }
    }
}
