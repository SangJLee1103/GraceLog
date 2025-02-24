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

enum HomeSection: Int, CaseIterable {
    case diary
    case contentList
}

final class HomeViewController: UIViewController {
    weak var coordinator: Coordinator?
    private let disposeBag = DisposeBag()
    private let reactor = HomeViewReactor()
    
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
        configureUI()
        configureTableView()
        bind()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        let headerView = HomeNavBarTableViewHeader()
        view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
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
        tableView.register(HomeCommunityDateHeaderView.self, forCellReuseIdentifier: HomeCommunityDateHeaderView.identifier)
        tableView.register(HomeCommunityUserTableViewCell.self, forCellReuseIdentifier: HomeCommunityUserTableViewCell.identifier)
        tableView.register(HomeCommunityMyTableViewCell.self, forCellReuseIdentifier: HomeCommunityMyTableViewCell.identifier)
    }
    
    private func bind() {
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else { return 0 }
        switch section {
        case .diary:
            return 1
        case .contentList:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = HomeSection(rawValue: section) else { return UIView() }
        
        switch section {
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
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = HomeSection(rawValue: section) else { return 0 }
        
        switch section {
        case .diary:
            return 130
        case .contentList:
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
