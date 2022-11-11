//
//  CoordinatorProtocol.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] {get set}
    var navigationController: UINavigationController { get set}
    
    func start()
}
