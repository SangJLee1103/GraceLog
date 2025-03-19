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
            let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCell.identifier, for: indexPath) as! MyInfoTableViewCell
            cell.selectionStyle = .none
            cell.setData(imgName: item.icon, title: item.title)
            return cell
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
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
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
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier) as? ProfileHeaderView
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 210 : UITableView.automaticDimension
    }
}
