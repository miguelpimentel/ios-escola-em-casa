//
//  Images.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 11/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit

enum Images: String {
    case loader = "ic_loader"

    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
