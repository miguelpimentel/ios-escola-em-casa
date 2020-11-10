//
//  Storyboard.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 03/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit

enum StoryboardViewable: String, Viewable {
    case main = "Main"
    case googleClassroom = "GC"
    case wikipedia = ""

    var storyboard: String {
        return "Main"
    }

    var key: String {
        return self.rawValue
    }

    func getViewController() -> UIViewController {
        return UIViewController()
    }
}
