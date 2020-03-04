//
//  HomePresenter.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 02/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import Foundation

protocol HomePresenterOutput: class {
    func showSearchResult(viewModel: [HomeModel.ViewModel])
    func showErrorMessage(message: String)
}

class HomePresenter: HomeInteractorOutput {
    
    weak var output: HomePresenterOutput?
    
    func onFailedSearchVolume(message: String) {
        output?.showErrorMessage(message: message)
    }
    
    func onSuccessSearchVolume(_ response: HomeModel.Response) {

        if let item = response.items {
            var homeModel: [HomeModel.ViewModel] = []
            for i in item {
                let _homeModel = HomeModel.ViewModel(title: i.volumeInfo?.title,
                                                     subtitle: i.volumeInfo?.subtitle,
                                                     smallThumbnail: i.volumeInfo?.imageLinks?.smallThumbnail,
                                                     thumbnail: i.volumeInfo?.imageLinks?.thumbnail,
                                                     publisher: i.volumeInfo?.publisher,
                                                     descriptionValue: i.volumeInfo?.description,
                                                     previewLink: i.volumeInfo?.previewLink,
                                                     buyLink: i.saleInfo?.buyLink,
                                                     totalItems: response.totalItems)
                homeModel.append(_homeModel)
            }
            self.output?.showSearchResult(viewModel: homeModel)
        }
    }
}
