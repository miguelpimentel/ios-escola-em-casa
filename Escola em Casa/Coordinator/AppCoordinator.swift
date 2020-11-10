//
//  AppCoordinator.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 05/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    // MARK: - Properties

    private let window: UIWindow
    private let navigationController = UINavigationController()

    var rootViewController: UIViewController {
        return navigationController
    }

    // MARK: - Initialization

    init(with window: UIWindow) {
        self.window = window
        super.init()
        self.navigationController.navigationBar.isHidden = true
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }

    // MARK: - Public methods

    override func start() {
        let viewController = Storyboards.loading.getViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
