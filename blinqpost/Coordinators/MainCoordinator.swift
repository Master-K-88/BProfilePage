//
//  MainCoordinator.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinator = [Coordinator]()
    var navigationController: UINavigationController
    
    init(childCoordinator: [Coordinator] = [Coordinator](), navigationController: UINavigationController) {
        self.childCoordinator = childCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = ViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
//    func gotoLearning() {
//        let child = LearningCoordinator(navigationController: navigationController)
//        child.parentCoordinator = self
//        childCoordinator.append(child)
//        child.start()
//    }
    
//    func gotoMastering() {
//        let child = MasteringCoordinator(navigationController: navigationController)
//        child.parentCoordinator = self
//        childCoordinator.append(child)
//        child.start()
//    }
    
    func childDidReturn(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinator.enumerated() {
            if coordinator === child {
                childCoordinator.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromVC) {
            return
        }
        
//        if let learningVC = fromVC as? LearningViewController {
//            childDidReturn(learningVC.coordinator)
//        }
//        if let masteringVC = fromVC as? MasteringViewController {
//            childDidReturn(masteringVC.coordinator)
//        }
        
    }
}
