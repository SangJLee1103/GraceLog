//
//  HomeNextViewController.swift
//  GraceLog
//
//  Created by 이상준 on 2/8/25.
//

import UIKit

final class HomeNextViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
