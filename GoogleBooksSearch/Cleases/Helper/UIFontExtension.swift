//
//  UIFontExtension.swift
//  GoogleBooksSearch
//
//  Created by Yaffi Azmi on 04/03/20.
//  Copyright © 2020 Yaffi Azmi. All rights reserved.
//

import UIKit

extension UIFont {
    public class func PoppinsRegular(with size:CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size)!
    }
    public class func PoppinsBold(with size:CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size)!
    }
    public class func PoppinsMedium(with size:CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size)!
    }
}
