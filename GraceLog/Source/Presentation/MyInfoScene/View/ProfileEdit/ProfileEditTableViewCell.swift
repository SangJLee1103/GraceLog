//
//  ProfileEditTableViewCell.swift
//  GraceLog
//
//  Created by 이상준 on 4/15/25.
//

import UIKit
import SnapKit
import Then

final class ProfileEditTableViewCell: UITableViewCell {
    static let identifier = "ProfileEditTableViewCell"
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .gray200
    }
    
    private let infoField = UITextField().then {
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 16)
    }
    
    private let dividerView = UIView().then {
        $0.setHeight(1)
        $0.backgroundColor = .gray200
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [titleLabel, infoField, dividerView].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(23)
            $0.top.equalToSuperview().offset(26)
        }
        
        infoField.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(40)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func updateUI(title: String, info: String) {
        titleLabel.text = title
        infoField.text = info
    }
}
