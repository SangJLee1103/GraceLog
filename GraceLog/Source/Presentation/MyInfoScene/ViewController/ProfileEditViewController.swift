//
//  MyInfoProfileViewController.swift
//  GraceLog
//
//  Created by 이상준 on 4/15/25.
//

import UIKit
import SnapKit
import Then
import ReactorKit
import RxSwift
import RxCocoa
import RxDataSources

final class ProfileEditViewController: UIViewController, View {
    var disposeBag = DisposeBag()
    
    typealias Reactor = ProfileEditViewReactor
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.separatorStyle = .none
        $0.backgroundColor = UIColor(hex: 0xF4F4F4)
        $0.sectionFooterHeight = 0
        $0.sectionHeaderTopPadding = 0
    }
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<ProfileEditSectionModel>(
        configureCell: { _, tableView, indexPath, item in
            switch item {
            case .imageItem(let item):
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileImageEditTableViewCell.identifier) as! ProfileImageEditTableViewCell
                cell.editButtonTap
                    .withUnretained(self)
                    .subscribe(onNext: { owner, _ in
                        owner.reactor?.showImagePicker { image in
                            owner.reactor?.action.onNext(.updateProfileImage(image))
                        }
                    })
                    .disposed(by: cell.disposeBag)
                
                return cell
                
            case .infoItem(let item, _):
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileEditTableViewCell.identifier) as! ProfileEditTableViewCell
                cell.updateUI(title: item.title, info: item.info)
                return cell
            }
        })
    
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
        tableView.register(ProfileEditTableViewCell.self, forCellReuseIdentifier: ProfileEditTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func bind(reactor: ProfileEditViewReactor) {
        // Action
        reactor.action.onNext(.viewDidLoad)
        
        // State
        reactor.state
            .map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
