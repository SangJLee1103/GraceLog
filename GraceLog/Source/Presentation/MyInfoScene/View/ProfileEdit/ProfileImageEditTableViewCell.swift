//
//  ProfileEditHeaderView.swift
//  GraceLog
//
//  Created by 이상준 on 4/15/25.
//

import UIKit
import SnapKit
import Then

final class ProfileImageEditTableViewCell: UITableViewCell {
    static let identifier = "ProfileImageEditTableViewCell"
    
    private let profileImgView = UIImageView().then {
        $0.setDimensions(width: 112, height: 112)
        $0.layer.cornerRadius = 56
        $0.image = UIImage(named: "profile")
        $0.clipsToBounds = false
    }
    
    private let editButton = UIButton().then {
        $0.setDimensions(width: 30, height: 30)
        $0.backgroundColor = .graceLightGray
        $0.setImage(UIImage(named: "edit_camera"), for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(profileImgView)
        profileImgView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(27)
            $0.centerX.equalToSuperview()
        }
        
        profileImgView.addSubview(editButton)
        editButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
        }
    }
}
