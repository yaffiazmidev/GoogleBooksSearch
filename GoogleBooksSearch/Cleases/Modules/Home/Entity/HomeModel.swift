//
//  HomeModel.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 02/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import Foundation
import SwiftyJSON

struct HomeModel {
    
    struct Request {
        struct HomeGetKeywordRequest {
            
            var keyword: String?
            init(keyword: String? = nil) {
                self.keyword = keyword
            }
            
            func paramters() -> [String: Any]? {
                
                var params: [String: Any] = [:]
                if let value = self.keyword {
                    params["q"] = value
                }
                return params
            }
        }
    }
    
    struct Response {
        var items: [BookEntityItems]?
        var kind: String?
        var totalItems: Int?
        
        init(json: JSON?) {
            
            if let data = json?["items"].array {
                var _items: [BookEntityItems] = []
                data.forEach({ (item) in
                    _items.append(BookEntityItems(json: item))
                    self.items = _items
                })
            }
            
            if let value = json?["kind"].string {
                self.kind = value
            }
            
            if let value = json?["totalItems"].int {
                self.totalItems = value
            }
        }
    }
    
    struct ViewModel {
        var title: String?
        var subtitle: String?
        var smallThumbnail: String?
        var thumbnail: String?
        var publisher: String?
        var descriptionValue: String?
        var previewLink: String?
        var buyLink: String?
        var totalItems: Int?
    }
}


struct BookEntityItems {

    var id: String?
    var selfLink: String?
    var saleInfo: BookEntitySaleInfo?
    var volumeInfo: BookEntityVolumeInfo?
    
    init(json: JSON?) {
        
        if let value = json?["id"].string {
            self.id = value
        }
    
        if let value = json?["selfLink"].string {
            self.selfLink = value
        }
        
        if let value = json?["saleInfo"].dictionaryObject {
            self.saleInfo = BookEntitySaleInfo(json: JSON(value))
        }
    
        if let value = json?["volumeInfo"].dictionary {
            self.volumeInfo = BookEntityVolumeInfo(json: JSON(value))
        }
    }
}

struct BookEntityVolumeInfo {

    var ratingsCount: Int?
    var contentVersion: String?
    var language: String?
    var infoLink: String?
    var description: String?
    var categories: [String]?
    var maturityRating: String?
    var imageLinks: BookEntityImageLinks?
    var title: String?
    var pageCount: Int?
    var publisher: String?
    var authors: [String]?
    var subtitle: String?
    var previewLink: String?
    var averageRating: Int?

    init(json: JSON?) {
        
        if let ratingsCount = json?["ratingsCount"].int {
            self.ratingsCount = ratingsCount
        }
        
        if let contentVersion = json?["contentVersion"].string {
            self.contentVersion = contentVersion
        }
        
        if let language = json?["language"].string {
            self.language = language
        }
        
        if let infoLink = json?["infoLink"].string {
            self.infoLink = infoLink
        }
        
        if let description = json?["description"].string {
            self.description = description
        }
        
        if let maturityRating = json?["maturityRating"].string {
            self.maturityRating = maturityRating
        }
        
        if let title = json?["title"].string {
            self.title = title
        }
        
        if let pageCount = json?["pageCount"].int {
            self.pageCount = pageCount
        }
        
        if let publisher = json?["publisher"].string {
            self.publisher = publisher
        }
        
        if let subtitle = json?["subtitle"].string {
            self.subtitle = subtitle
        }
        
        if let previewLink = json?["previewLink"].string {
            self.previewLink = previewLink
        }
        
        if let averageRating = json?["averageRating"].int {
            self.averageRating = averageRating
        }
        
        if let value = json?["imageLinks"].dictionaryObject {
            self.imageLinks = BookEntityImageLinks(json: JSON(value))
        }
    }
}

struct BookEntitySaleInfo {

    var listPrice: BookEntityListPrice?
    var country: String?
    var buyLink: String?
    var isEbook: Bool?
    var saleability: String?
    
    init(json: JSON?) {
        
        if let value = json?["listPrice"].dictionaryObject {
            self.listPrice = BookEntityListPrice(json: JSON(value))
        }
        
        if let value = json?["country"].string {
            self.country = value
        }
        
        if let value = json?["buyLink"].string {
            self.buyLink = value
        }
        
        if let value = json?["isEbook"].bool {
            self.isEbook = value
        }
        
        if let value = json?["saleability"].string {
            self.saleability = value
        }
    }
}


struct BookEntityImageLinks {
    
    var smallThumbnail: String?
    var thumbnail: String?
    
    init(json: JSON?) {
        
        if let value = json?["smallThumbnail"].string {
            self.smallThumbnail = value
        }
        
        if let value = json?["thumbnail"].string {
            self.thumbnail = value
        }
    }
}

struct BookEntityListPrice {
    
    var amountInMicros: Int?
    var currencyCode: String?
    
    init(json: JSON?) {
    
        if let value = json?["amountInMicros"].int {
            self.amountInMicros = value
        }
      
        if let value = json?["currencyCode"].string {
          self.currencyCode = value
        }
    }
}
