//
//  HomeTableViewHeader.swift
//  GraceLog
//
//  Created by 이상준 on 2/8/25.
//

import UIKit
import Then
import SnapKit

final class HomeTableViewHeader: UITableViewHeaderFooterView {
    static let identifier = "HomeTableViewHeader"
    
    private let titleLabel = UILabel().then {
        $0.textColor = .themeColor
        $0.font = UIFont(name: "Pretendard-Bold", size: 12)
    }
    
    private let descLabel = UILabel().then {
        $0.textColor = .graceGray
        $0.font = UIFont(name: "Pretendard-Regular", size: 24)
        $0.numberOfLines = 4
    }
    
    private let paragraphLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = UIColor(hex: 0xF4F4F4) 
        
        [titleLabel, descLabel, paragraphLabel].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        descLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(14)
        }
    }
    
    func configure(title: String, desc: String) {
        titleLabel.text = title
        descLabel.text = desc
    }
}

