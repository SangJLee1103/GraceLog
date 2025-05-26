//
//  ProfileEditHeaderView.swift
//  GraceLog
//
//  Created by 이상준 on 4/15/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class ProfileImageEditTableViewCell: UITableViewCell {
    static let identifier = "ProfileImageEditTableViewCell"
    
    let editButtonTap = PublishRelay<Void>()
    
    var disposeBag = DisposeBag()
    
    private let profileImgView = UIImageView().then {
        $0.setDimensions(width: 112, height: 112)
        $0.layer.cornerRadius = 56
        $0.clipsToBounds = true
        
        let profileImageUrl = AuthManager.shared.getUser()?.profileImage ?? ""
        if !profileImageUrl.isEmpty, let url = URL(string: profileImageUrl) {
            $0.sd_setImage(with: url)
        } else {
            $0.image = UIImage(named: "profile")
        }
    }
    
    private let editButton = UIButton().then {
        $0.setDimensions(width: 30, height: 30)
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .graceLightGray
        $0.setImage(UIImage(named: "edit_camera"), for: .normal)
        $0.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(profileImgView)
        profileImgView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(27)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
        }
        
        contentView.addSubview(editButton)
        editButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(profileImgView)
        }
    }
    
    @objc private func didTapEditButton() {
        editButtonTap.accept(())
    }
    
    func updateUI(_ image: UIImage?) {
        profileImgView.image = image ?? UIImage(named: "profile")
    }
}
