//
//  HomeWorker.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 02/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol HomeWorkerDelegate: class {
//    func getSeachVolume(callback: @escaping ((BookEntity?) -> ()))
    
    
    func processGetData(model: HomeModel.Request.HomeGetKeywordRequest, completion: @escaping (Swift.Result<JSON, NetworkError>) -> Void)
}

class HomeWorker: HomeWorkerDelegate {
    private var api = APIService.share
    
    func processGetData(model: HomeModel.Request.HomeGetKeywordRequest, completion: @escaping (Result<JSON, NetworkError>) -> Void) {
        api.request(endpoint: GeneralEndpoint.getKeyword(model: model), completion: completion)
    }
}
