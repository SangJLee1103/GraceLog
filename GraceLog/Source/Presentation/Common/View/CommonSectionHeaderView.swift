//
//  CommonSectionHeaderView.swift
//  GraceLog
//
//  Created by 이상준 on 4/5/25.
//

import UIKit

final class CommonSectionHeaderView: UITableViewHeaderFooterView {
    static let identifier = "CommonSectionHeaderView"
    
    private let titleLabel = UILabel().then {
        $0.textColor = .themeColor
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(30)
        }
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
