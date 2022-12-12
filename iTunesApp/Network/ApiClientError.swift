//
//  ApiClientError.swift
//  iTunesApp
//
//  Created by admin on 12.12.2022.
//

import Foundation

public protocol APIError: Decodable {
    var status_message: String { get }
    var status_code: Int { get }
}

struct ClientError: APIError {
    var status_message: String
    var status_code: Int
}

public enum APIClientError: Error {
    case handledError(error: APIError)
    case networkError
    case decoding(error: DecodingError?)
    case timeout
    case message(String)

    public var message: String {
        switch self {
        case .handledError(let error):
            return error.status_message
        case .decoding:
            return "Beklenmeyen bir hata oluştu"
        case .networkError:
            return "Beklenmeyen bir hata oluştu."
        case .timeout:
            return "İstek zaman aşımına uğradı, daha sonra tekrar deneyiniz."
        case .message(let message):
            return message
        }
    }

    public var title: String {
        switch self {
        case .handledError, .decoding, .networkError, .timeout, .message:
            return "Error"
        }
    }

    public var debugMessage: String {
        switch self {
        case .handledError(let error):
            return error.status_message
        case .decoding(let decodingError):
            guard let decodingError = decodingError else { return "Decoding Error" }
            return "\(decodingError)"
        case .networkError:
            return "Network error"
        case .timeout:
            return "Timeout"
        case .message(let message):
            return message
        }
    }

    public var code: Int {
        switch self {
        case .handledError(let error):
            return error.status_code
        default:
            return 500
        }
    }
}
