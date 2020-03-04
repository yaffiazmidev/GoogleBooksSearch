//
//  HomeInteractor.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 02/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol HomeInteractorInput: class {
    func fetchSearchVolume(model: HomeModel.Request.HomeGetKeywordRequest)
}
protocol HomeInteractorOutput: class {
    func onSuccessSearchVolume(_ response: HomeModel.Response)
    func onFailedSearchVolume(message: String)
}

class HomeInteractor: HomeInteractorInput {
    
    var output: HomeInteractorOutput!
    var worker: HomeWorkerDelegate?
    
    func fetchSearchVolume(model: HomeModel.Request.HomeGetKeywordRequest) {
        worker?.processGetData(model: model, completion: { (result) in
            switch result {
            case .failure(let err):
                self.output.onFailedSearchVolume(message: "Failed to serach with error:  \(err.localizedDescription)")
            case .success(let value):
                let modelResponse = HomeModel.Response(json: JSON(value))
                self.output.onSuccessSearchVolume(modelResponse)
            }
        })
    }
}
