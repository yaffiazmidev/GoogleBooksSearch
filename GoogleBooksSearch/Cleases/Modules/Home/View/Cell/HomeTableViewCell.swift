//
//  HomeTableViewCell.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 04/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var smallThumbnailImage: UIImageView!
    
    var items: HomeModel.ViewModel? {
        didSet {
            titleLabel.text = items?.title
            descriptionLabel.text = items?.descriptionValue
            publisherLabel.text = "Publisher: \(items?.publisher ?? "")"
            guard let url = URL(string: items?.smallThumbnail ?? "") else { return }
            smallThumbnailImage.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        smallThumbnailImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
