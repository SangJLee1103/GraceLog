//
//  MyInfoViewController.swift
//  GraceLog
//
//  Created by 이상준 on 12/8/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ReactorKit

final class MyInfoViewController: UIViewController, View {
    typealias Reactor = MyInfoViewReactor
    
    var disposeBag = DisposeBag()
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = UIColor(hex: 0xF4F4F4)
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<MyInfoSection>(
        configureCell: { [weak self] dataSource, tableView, indexPath, item in
            if let profileItem = item as? ProfileItem {
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
                cell.selectionStyle = .none
                //                cell.configure(image: profileItem.imageUrl, name: profileItem.name, email: profileItem.email)
                return cell
            } else if let myInfoItem = item as? MyInfoItem {
                let section = dataSource[indexPath.section]
                
                if case .logout = section, let myInfoItem = item as? MyInfoItem {
                    let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoButtonTableViewCell.identifier, for: indexPath) as! MyInfoButtonTableViewCell
                    cell.updateUI(title: myInfoItem.title, textColor: .black)
                    return cell
                } else if case .withdrawal = section, let myInfoItem = item as? MyInfoItem {
                    let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoButtonTableViewCell.identifier, for: indexPath) as! MyInfoButtonTableViewCell
                    cell.updateUI(title: myInfoItem.title, textColor: .themeColor)
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCell.identifier, for: indexPath) as! MyInfoTableViewCell
                    cell.selectionStyle = .none
                    cell.separatorInset = .init(top: 0, left: 61, bottom: 0, right: 0)
                    cell.updateUI(imgName: myInfoItem.icon, title: myInfoItem.title)
                    return cell
                }
            }
            return UITableViewCell()
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = MyInfoViewReactor()
        configureUI()
        configureTableView()
    }
    
    private func configureUI() {
        title = "내 계정"
        
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(safeArea)
        }
    }
    
    private func configureTableView() {
        tableView.register(MyInfoSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: MyInfoSectionHeaderView.identifier)
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.register(MyInfoTableViewCell.self, forCellReuseIdentifier: MyInfoTableViewCell.identifier)
        tableView.register(MyInfoButtonTableViewCell.self, forCellReuseIdentifier: MyInfoButtonTableViewCell.identifier)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func bind(reactor: MyInfoViewReactor) {
        Observable.just(Reactor.Action.viewDidLoad)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension MyInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let title = dataSource[section].title {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyInfoSectionHeaderView.identifier) as? MyInfoSectionHeaderView
            headerView?.setTitle(title)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = dataSource[section]
        
        switch sectionModel {
        case .profile, .withdrawal:
            return .leastNonzeroMagnitude
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionModel = dataSource[indexPath.section]
        
        switch sectionModel {
        case .profile:
            return UITableView.automaticDimension
        default:
            return 40
        }   
    }
}
