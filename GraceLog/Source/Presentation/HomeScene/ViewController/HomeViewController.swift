//
//  HomeViewController.swift
//  GraceLog
//
//  Created by 이상준 on 12/8/24.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

enum HomeSection: Int, CaseIterable {
    case diary
    case contentList
}

enum CommunitySection: Int, CaseIterable {
    case community
}

final class HomeViewController: UIViewController, View {
    weak var coordinator: Coordinator?
    var disposeBag = DisposeBag()
    
    private let headerView = HomeNavBarTableViewHeader()
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = UIColor(hex: 0xF4F4F4)
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.sectionHeaderTopPadding = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = HomeViewReactor()
        configureUI()
        configureTableView()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(47)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(safeArea)
        }
    }
    
    
    private func configureTableView() {
        // User DataSource
        tableView.register(HomeTableViewHeader.self, forHeaderFooterViewReuseIdentifier: HomeTableViewHeader.identifier)
        tableView.register(HomeDiaryTableViewCell.self, forCellReuseIdentifier: HomeDiaryTableViewCell.identifier)
        tableView.register(HomeRecommendTableViewCell.self, forCellReuseIdentifier: HomeRecommendTableViewCell.identifier)
        tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: CommunityTableViewCell.identifier)
        
        // Community DataSource
        tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: CommunityTableViewCell.identifier)
        tableView.register(HomeCommunityDateHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeCommunityDateHeaderView.identifier)
        tableView.register(HomeCommunityUserTableViewCell.self, forCellReuseIdentifier: HomeCommunityUserTableViewCell.identifier)
        tableView.register(HomeCommunityMyTableViewCell.self, forCellReuseIdentifier: HomeCommunityMyTableViewCell.identifier)
    }
    
    func bind(reactor: HomeViewReactor) {
        headerView.segmentTapped
            .map { isUserSelected in
                return isUserSelected ?
                HomeViewReactor.Action.userButtonTapped :
                HomeViewReactor.Action.groupButtonTapped
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { state in
                return state.currentSegment == .user
            }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { owner, isUserSelected in
                owner.headerView.updateUI(isUserSelected: isUserSelected)
                owner.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let reactor = reactor else { return 0 }
        
        switch reactor.currentState.currentSegment {
        case .user:
            return HomeSection.allCases.count
        case .group:
            return reactor.currentState.communitySections.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let reactor = reactor else { return 0 }
        
        switch reactor.currentState.currentSegment {
        case .user:
            guard let homeSection = HomeSection(rawValue: section) else { return 0 }
            switch homeSection {
            case .diary:
                return 1
            case .contentList:
                return 2
            }
        case .group:
            if section == 0 {
                return 1
            } else {
                return reactor.currentState.communitySections[section - 1].items.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reactor = reactor else { return UITableViewCell() }
        
        switch reactor.currentState.currentSegment {
        case .user:
            guard let section = HomeSection(rawValue: indexPath.section) else { return UITableViewCell() }
            
            switch section {
            case .diary:
                let cell = tableView.dequeueReusableCell(withIdentifier: HomeDiaryTableViewCell.identifier, for: indexPath) as! HomeDiaryTableViewCell
                cell.selectionStyle = .none
                return cell
                
            case .contentList:
                let cell = tableView.dequeueReusableCell(withIdentifier: HomeRecommendTableViewCell.identifier, for: indexPath) as! HomeRecommendTableViewCell
                cell.selectionStyle = .none
                
                if indexPath.row == 0 {
                    cell.configure(title: "말씀노트", image: UIImage(named: "content1") ?? UIImage())
                } else {
                    cell.configure(title: "더메세지 랩The Message LAB", image: UIImage(named: "content2") ?? UIImage())
                }
                
                return cell
            }
        case .group:
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTableViewCell.identifier, for: indexPath) as! CommunityTableViewCell
                cell.selectionStyle = .none
                cell.configure(with: reactor.currentState.communityButtons)
                return cell
            } else {
                let item = reactor.currentState.communitySections[indexPath.section - 1].items[indexPath.row]
                
                switch item.type {
                case .my:
                    let cell = tableView.dequeueReusableCell(withIdentifier: HomeCommunityMyTableViewCell.identifier, for: indexPath) as! HomeCommunityMyTableViewCell
                    cell.selectionStyle = .none
                    
                    if let title = item.title, let subtitle = item.subtitle, let likes = item.likes, let comments = item.comments {
                        cell.configure(title: title, subtitle: subtitle, likes: likes, comments: comments)
                    }
                    return cell
                case .regular:
                    let cell = tableView.dequeueReusableCell(withIdentifier: HomeCommunityUserTableViewCell.identifier, for: indexPath) as! HomeCommunityUserTableViewCell
                    cell.selectionStyle = .none
                    
                    if let username = item.username, let title = item.title, let subtitle = item.subtitle, let likes = item.likes, let comments = item.comments {
                        cell.configure(username: username, title: title, subtitle: subtitle, likes: likes, comments: comments)
                    }
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let reactor = reactor else { return nil }
        
        switch reactor.currentState.currentSegment {
        case .user:
            guard let homeSection = HomeSection(rawValue: section) else { return UIView() }
            
            switch homeSection {
            case .diary:
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableViewHeader.identifier) as! HomeTableViewHeader
                header.configure(
                    title: "오늘의 말씀",
                    desc: "순종이 제사보다 낫고 듣는 것이 숫양의 기름보다 나으니",
                    paragraph: "사무엘상 5:22"
                )
                return header
            case .contentList:
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableViewHeader.identifier) as! HomeTableViewHeader
                header.configure(title: "추천영상", desc: "#순종 #도전", paragraph: nil)
                return header
            }
            
        case .group:
            if section == 0 {
                return nil
            } else {
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeCommunityDateHeaderView.identifier) as! HomeCommunityDateHeaderView
                header.configure(date: reactor.currentState.communitySections[section - 1].date)
                return header
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let reactor = reactor else { return 0 }
        
        switch reactor.currentState.currentSegment {
        case .user:
            guard let homeSection = HomeSection(rawValue: section) else { return 0 }
            
            switch homeSection {
            case .diary:
                return 130
            case .contentList:
                return 80
            }
        case .group:
            if section == 0 {
                return .leastNonzeroMagnitude
            } else {
                return 50
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
