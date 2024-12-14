//
//  Coordinator.swift
//  GraceLog
//
//  Created by 이상준 on 12/7/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var childerCoordinators: [Coordinator] { get set }
    func start()
}
