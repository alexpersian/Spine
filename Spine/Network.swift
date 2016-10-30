//
//  Network.swift
//
//  Created by Alexander Persian on 6/21/16.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case unknown
    case invalidResponse

    var description: String {
        switch self {
        case .unknown:
            return "An unknown error has occured."
        case .invalidResponse:
            return "Received an invalid response."
        }
    }
}

protocol NetworkCancelable {
    func cancel()
}

extension URLSessionDataTask: NetworkCancelable { }

protocol Network {
    func makeRequestForData(_ request: NetworkRequest,
                            success: @escaping (Data) -> Void,
                            failure: @escaping (Error) -> Void) -> NetworkCancelable?
    func makeRequestForJSON(_ request: NetworkRequest,
                            success: @escaping ([String : AnyObject]) -> Void,
                            failure: @escaping (Error) -> Void) -> NetworkCancelable?
}
