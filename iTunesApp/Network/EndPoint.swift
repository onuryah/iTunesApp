//
//  EndPoint.swift
//  iTunesApp
//
//  Created by admin on 12.12.2022.
//

import Foundation
import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod

public protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
}

public extension Endpoint {
    var encoding: ParameterEncoding {
        switch method {
        case .get: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }
    var parameters: [String: Any] { [:] }
    var url: String { "\(baseUrl)\(path)"}
}
