//
//  MyInfoProfileViewController.swift
//  GraceLog
//
//  Created by 이상준 on 4/15/25.
//

import UIKit
import SnapKit
import Then
import Toast_Swift
import NVActivityIndicatorView

import ReactorKit
import RxSwift
import RxCocoa
import RxDataSources

final class ProfileEditViewController: UIViewController, View {
    var disposeBag = DisposeBag()
    
    typealias Reactor = ProfileEditViewReactor
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.separatorStyle = .none
        $0.backgroundColor = .white
    }
    
    private let saveBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: nil, action: nil)
    private let activityIndicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .black, padding: 0).then {
        $0.isHidden = true
    }
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<ProfileEditSectionModel>(
        configureCell: { _, tableView, indexPath, item in
            guard let reactor = self.reactor else {
                return UITableViewCell()
            }
            
            switch item {
            case .imageItem(let item):
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileImageEditTableViewCell.identifier) as! ProfileImageEditTableViewCell
                cell.updateUI(item.image)
                cell.editButton.rx.tap
                    .withUnretained(self)
                    .subscribe(onNext: { owner, _ in
                        owner.reactor?.showImagePicker { image in
                            owner.reactor?.action.onNext(.updateProfileImage(image))
                        }
                    })
                    .disposed(by: cell.disposeBag)
                
                return cell
            case .infoItem(let item, let itemType):
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileEditTableViewCell.identifier) as! ProfileEditTableViewCell
                
                cell.configure(
                    title: item.title,
                    placeholder: item.placeholder,
                    info: item.info,
                    itemType: itemType
                ) { [weak self] text, type in
                    guard let reactor = self?.reactor else { return }
                    
                    switch type {
                    case .nicknameEdit:
                        reactor.action.onNext(.updateNickname(text))
                    case .nameEdit:
                        reactor.action.onNext(.updateName(text))
                    case .messageEdit:
                        reactor.action.onNext(.updateMessage(text))
                    default:
                        break
                    }
                }
                return cell
            }
        })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    private func configureUI() {
        navigationItem.rightBarButtonItem = saveBarButtonItem
        
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
        
        saveBarButtonItem.rx.tap
            .map { Reactor.Action.didTapSaveButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map { $0.sections }
            .distinctUntilChanged()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isLoading }
            .bind(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.isHidden = false
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.error }
            .subscribe(onNext: { [weak self] error in
                self?.view.makeToast(error?.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.saveSuccess }
            .filter { $0 }
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.view.makeToast("프로필이 성공적으로 수정되었습니다")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    owner.reactor?.coordinator?.didFinishProfileEdit()
                }
            })
            .disposed(by: disposeBag)
    }
}
