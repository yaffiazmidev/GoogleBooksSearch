//
//  HomeRouter.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 02/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import Foundation

protocol HomeRouterProtocol: class {}

class HomeRouter: HomeRouterProtocol {
    weak var viewController: HomeViewController?
}
