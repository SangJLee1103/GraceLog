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
    }
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<MyInfoSection>(
        configureCell: { [weak self] dataSource, tableView, indexPath, item in
            if let profileItem = item as? ProfileItem {
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
                //                cell.configure(image: profileItem.imageUrl, name: profileItem.name, email: profileItem.email)
                return cell
            } else if let myInfoItem = item as? MyInfoItem {
                let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCell.identifier, for: indexPath) as! MyInfoTableViewCell
                cell.selectionStyle = .none
                cell.setData(imgName: myInfoItem.icon, title: myInfoItem.title)
                return cell
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
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 28 , bottom: 0, right: 25)
        tableView.register(MyInfoSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: MyInfoSectionHeaderView.identifier)
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.register(MyInfoTableViewCell.self, forCellReuseIdentifier: MyInfoTableViewCell.identifier)
        
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
        return dataSource[section].title != nil ? 40 : 0
    }
}
