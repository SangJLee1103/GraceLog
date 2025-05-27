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

extension Coordinator {
    /// Removing a coordinator inside a children. This call is important to prevent memory leak.
    /// - Parameter coordinator: Coordinator that finished.
    func childDidFinish(_ coordinator : Coordinator){
        // Call this if a coordinator is done.
        for (index, child) in childerCoordinators.enumerated() {
            if child === coordinator {
                childerCoordinators.remove(at: index)
                break
            }
        }
    }
}
