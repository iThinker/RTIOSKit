//
//  String+Extensions.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-02-07.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

public extension String.CharacterView {
    
    public subscript(index: Int) -> Character {
        get {
            return self[self.index(self.startIndex, offsetBy: index)]
        }
    }
    
}
