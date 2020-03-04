//
//  BookDetailViewController.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 04/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import UIKit
import Kingfisher

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var pulisherLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var bookEntityItems: HomeModel.ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = bookEntityItems?.title
        subtitleLabel.text = "Subtitle: \(bookEntityItems?.subtitle ?? "")"
        pulisherLabel.text = "Publisher: \(bookEntityItems?.publisher ?? "")"
        descriptionLabel.text = bookEntityItems?.descriptionValue
        guard let url = URL(string: bookEntityItems?.thumbnail ?? "") else { return }
        thumbnailImage.kf.setImage(with: url)
    }
    
    @IBAction func didClickBuyButton(_ sender: Any) {
        guard let url = URL(string: self.bookEntityItems?.buyLink ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func didClickPreviewButton(_ sender: Any) {
        guard let url = URL(string: self.bookEntityItems?.previewLink ?? "") else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func didClickBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
