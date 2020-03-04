//
//  SearchResultViewController.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 04/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let cellIentifier = "SearchResultTableViewCell"
    
    var items: [BookEntityItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(UINib(nibName: cellIentifier, bundle: nil), forCellReuseIdentifier: cellIentifier)
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIentifier, for: indexPath) as! SearchResultTableViewCell
        let item = items[indexPath.row]
        cell.items = item
        return cell
    }
    
    
}
