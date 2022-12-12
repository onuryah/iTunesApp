//
//  MainEndPointItem.swift
//  iTunesApp
//
//  Created by admin on 12.12.2022.
//

import Foundation

import Foundation

enum MainEndpointItem: Endpoint {
    
    case upcoming(query: String)
    
    var baseUrl: String { ApiConstant().MEDIA_BASE_URL }
    
    var path: String {
        switch self {
        case .upcoming(let query):
            return ApiConstant().searchMedia(searchingText: query)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
}
