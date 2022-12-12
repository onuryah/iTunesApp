//
//  ApiConstant.swift
//  iTunesApp
//
//  Created by admin on 12.12.2022.
//

import Foundation
struct ApiConstant {
    
    let MEDIA_BASE_URL = "https://itunes.apple.com/"
    let SEARCH_PARAMS_KEY = "search?term="
    let FILTER_MEDIA_KEY = "&media="
    let FILTER_MEDIA_VALUE = "software"
    
      func searchMedia(searchingText: String) -> String {
        return SEARCH_PARAMS_KEY+searchingText+FILTER_MEDIA_KEY+FILTER_MEDIA_VALUE
    }
}
