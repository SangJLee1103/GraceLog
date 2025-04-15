//
//  MyInfoProfileViewController.swift
//  GraceLog
//
//  Created by 이상준 on 4/15/25.
//

import UIKit
import SnapKit
import Then

final class ProfileEditViewController: UIViewController {
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = UIColor(hex: 0xF4F4F4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    private func configureUI() {
        navigationItem.leftBarButtonItem?.tintColor = .themeColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .themeColor
           
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView() {
        tableView.register(ProfileImageEditTableViewCell.self, forCellReuseIdentifier: ProfileImageEditTableViewCell.identifier)
        tableView.register(ProfileEditTableViewCell.self, forCellReuseIdentifier: ProfileImageEditTableViewCell.identifier)
    }
}
