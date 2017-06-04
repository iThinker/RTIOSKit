//
//  ReuseIdentifier.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-25.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

public extension UICollectionViewCell {
    public class func defaultReuseIdentifier() -> String {
        return String(describing: self)
    }
}

public extension UITableViewCell {
    public class func defaultReuseIdentifier() -> String {
        return String(describing: self)
    }
}
