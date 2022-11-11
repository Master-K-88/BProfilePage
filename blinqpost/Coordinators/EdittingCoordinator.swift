//
//  EditViewCoordinator.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import UIKit

class EdittingCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = EdittingViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
