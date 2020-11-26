//
//  Coordinator.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 08/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit

class Coordinator: NSObject, UINavigationControllerDelegate {

    // MARK: - Properties

    var didFinish: ((Coordinator) -> Void)?

    var childCoordinators: [Coordinator] = []

    // MARK: - Methods

    func start() { }

    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) { }
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController, animated: Bool) { }

    func pushCoordinator(_ coordinator: Coordinator) {
        coordinator.didFinish = { [weak self] coordinator in
            self?.popCoordinator(coordinator)
        }

        coordinator.start()
        childCoordinators.append(coordinator)
    }

    func popCoordinator(_ coordinator: Coordinator) {
        guard let index = childCoordinators.firstIndex(where: { $0 === coordinator }) else { return }
        childCoordinators.remove(at: index)
    }
}
