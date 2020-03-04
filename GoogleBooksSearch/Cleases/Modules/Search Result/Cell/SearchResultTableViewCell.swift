//
//  SearchResultTableViewCell.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 04/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    
    var items: BookEntityItems? {
        didSet {
            titleLabel.text = items?.volumeInfo?.title
            
//            items?.volumeInfo.ti
//            if let item = items?.items {
//                item.forEach { (_item) in
//
//                }
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
