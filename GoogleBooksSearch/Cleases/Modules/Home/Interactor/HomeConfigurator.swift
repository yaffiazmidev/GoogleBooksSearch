//
//  HomeConfigurator.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 02/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import Foundation

class HomeConfigurator {
    static func configure(viewController: HomeViewController) {
        
        let worker: HomeWorker = HomeWorker()
        let presenter: HomePresenter = HomePresenter()
        presenter.output = viewController
        
        let router: HomeRouter = HomeRouter()
        router.viewController = viewController
        
        let interactor: HomeInteractor = HomeInteractor()
        interactor.output = presenter
        interactor.worker = worker
        
        viewController.interactor = interactor
        viewController.router = router
        
    }
}
