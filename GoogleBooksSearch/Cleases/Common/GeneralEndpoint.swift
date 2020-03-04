//
//  GeneralEndpoint.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 04/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import Foundation
import Alamofire

enum GeneralEndpoint {
    case getKeyword(model: HomeModel.Request.HomeGetKeywordRequest)
}

extension GeneralEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getKeyword:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getKeyword:
            return "https://www.googleapis.com/books/v1/volumes"
        }
    }

    var parameter: Parameters? {
        switch self {
        case .getKeyword(let model):
            return model.paramters()
        }
    }

    var header: HTTPHeaders? {
        switch self {
        case .getKeyword:
            return [
                "Content-Type": "application/json",
            ]
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .getKeyword:
            return URLEncoding.queryString
        }
    }
}
