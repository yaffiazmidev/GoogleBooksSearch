//
//  HomeViewController.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 04/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController  {

    @IBOutlet weak var tableView: UITableView!
    
    let searchBarTextField: UITextField = UITextField()
    
    var router: HomeRouterProtocol!
    var interactor: HomeInteractorInput!
    
    var bookEntityItems: [HomeModel.ViewModel] = []
    
    let searchIconImage: UIImageView = {
       let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        view.image  = UIImage(systemName: "magnifyingglass")
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3529411765, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cellIdentifier = "HomeTableViewCell"
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchIconImage)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        HomeConfigurator.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        HomeConfigurator.configure(viewController: self)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func setupSearchBar() {
        if let width = self.navigationController?.navigationBar.frame.size.width {
            searchBarTextField.frame = CGRect(x: 0, y: 0, width: width - 64, height: 21)
        }
        
        self.navigationItem.titleView = self.searchBarTextField
        searchBarTextField.placeholder = "Search some book"
        searchBarTextField.delegate = self
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookEntityItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HomeTableViewCell
        let item = bookEntityItems[indexPath.row]
        cell.items = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BookDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.bookEntityItems = self.bookEntityItems[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performAction(keyword: self.searchBarTextField.text ?? "")
        return true
    }

    func performAction(keyword: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.interactor.fetchSearchVolume(model: HomeModel.Request.HomeGetKeywordRequest(keyword: keyword))
        }
    }
}

extension HomeViewController: HomePresenterOutput {
    func showErrorMessage(message: String) {
        print(message)
    }
    
    func showSearchResult(viewModel: [HomeModel.ViewModel]) {
        self.bookEntityItems = viewModel
        self.tableView.reloadData()
    }
}

