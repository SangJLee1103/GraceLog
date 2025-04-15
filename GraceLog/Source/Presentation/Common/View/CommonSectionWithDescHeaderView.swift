//
//  CommonSectionWithDescHeaderView.swift
//  GraceLog
//
//  Created by 이상준 on 4/13/25.
//

import UIKit
import SnapKit
import Then

final class CommonSectionWithDescHeaderView: UITableViewHeaderFooterView {
    static let identifier = "CommonSectionWithDescHeaderView"
    
    private let titleLabel = UILabel().then {
        $0.textColor = .themeColor
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
    }
    
    private let descLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, descLabel])
        stack.axis = .vertical
        stack.spacing = 2
        
        contentView.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(6)
        }
    }
    
    func setTitleWithDesc(title: String, desc: String) {
        titleLabel.text = title
        descLabel.text = desc
    }
}
