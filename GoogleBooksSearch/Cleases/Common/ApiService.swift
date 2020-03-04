//
//  ApiService.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 04/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum NetworkError: Int, Error {
    case notFound = 404
    case forbidden = 403
    case badRequest = 400
    case unauthorized = 401
    case serverError = 500
    case serviceUnavailable = 503
    case noInternet = -1009
    case requestTimeOut = -1001
}

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Data Not Found"
        case .forbidden:
            return "Access Forbidden"
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .serverError:
            return "Internal Server Error"
        case .serviceUnavailable:
            return "Internal Server Error"
        case .noInternet:
            return "No Internet Access"
        case .requestTimeOut:
            return "Request time out"
        }
    }
}

protocol IEndpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameter: Parameters? { get }
    var header: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

class APIService {
    static let share = APIService()
    
    private var dataRequest: DataRequest?
    
    @discardableResult
    private func _dataRequest(
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil
    )
        -> DataRequest {
        return SessionManager.default.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
    }
    
    func request<T: IEndpoint>(endpoint: T, completion: @escaping (Swift.Result<JSON, NetworkError>) -> Void) {
        if Connectivity.isConnectedToInternet {
            DispatchQueue.global(qos: .background).async {
                self.dataRequest = self._dataRequest(url: endpoint.path,
                                                     method: endpoint.method,
                                                     parameters: endpoint.parameter,
                                                     encoding: endpoint.encoding,
                                                     headers: endpoint.header)
                
                self.dataRequest?.responseJSON(completionHandler: { response in
                    debugPrint(response)
                    
                    DispatchQueue.main.async {
                        if let statusCode = response.response?.statusCode, let errorType = NetworkError(rawValue: statusCode) {
                            var errorState: NetworkError?
                            switch errorType {
                            case .serverError:
                                if let data = response.data, JSON(data)["error_message"].string != nil {
                                    errorState = NetworkError(rawValue: 99)
                                } else {
                                    errorState = NetworkError(rawValue: statusCode)
                                }
                            default:
                                errorState = NetworkError(rawValue: statusCode)
                            }
                            
                            if errorState != nil {
                                completion(.failure(errorState!))
                                return
                            }
                        }
                        
                        guard let data = response.data else {
                            completion(.failure(NetworkError.notFound))
                            return
                        }
                        
                        let json = JSON(data)
                        
                        if let errCode = json["error"].string, let errInt = Int(errCode), let errType = NetworkError(rawValue: errInt) {
                            completion(.failure(errType))
                            return
                        }
                        
                        completion(.success(json))
                    }
                })
            }
        } else {
            completion(.failure(NetworkError.noInternet))
        }
    }
    
    func cancelRequest(_ completion: (() -> Void)? = nil) {
        dataRequest?.cancel()
        completion?()
    }
    
    func cancelAllRequest(_ completion: (() -> Void)? = nil) {
        dataRequest?.session.getAllTasks(completionHandler: { tasks in
            tasks.forEach { task in
                task.cancel()
            }
        })
        completion?()
    }
}

