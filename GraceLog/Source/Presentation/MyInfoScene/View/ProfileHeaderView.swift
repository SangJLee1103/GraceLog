//
//  ProfileHeaderView.swift
//  GraceLog
//
//  Created by 이상준 on 3/15/25.
//

import UIKit
import SnapKit
import Then

final class ProfileHeaderView: UITableViewHeaderFooterView {
    static let identifier = "ProfileHeaderView"
    
    private let profileImgView = UIImageView().then {
        $0.setDimensions(width: 112, height: 112)
        $0.layer.cornerRadius = 56
        $0.image = UIImage(named: "profile")
    }
    
    private let nameLabel = UILabel().then {
        $0.textColor = .themeColor
        $0.font = UIFont(name: "Pretendard-Bold", size: 20)
        $0.textAlignment = .center
        $0.text = "윤승렬"
    }
    
    private let emailLabel = UILabel().then {
        $0.textColor = .graceGray
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.textAlignment = .center
        $0.text = "dbs3153@naver.com"
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [profileImgView, nameLabel, emailLabel].forEach {
            addSubview($0)
        }
        
        profileImgView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(27)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImgView.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
