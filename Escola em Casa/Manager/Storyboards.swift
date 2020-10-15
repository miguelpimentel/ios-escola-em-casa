//
//  StoryboardManager.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 14/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit

protocol Viewable {
    var storyboard: String { get }
    func getViewController() -> UIViewController
}

enum Storyboards: String {
    case main = "ResultView"
    case loading = "LoadingView"
    case howAccess = "HowAccessClassRoomView"
    case site = "SiteWebView"
}

extension Storyboards: Viewable {

    var storyboard: String {
        return "Main"
    }

    func getViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: self.storyboard, bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: self.rawValue)
    }
}
