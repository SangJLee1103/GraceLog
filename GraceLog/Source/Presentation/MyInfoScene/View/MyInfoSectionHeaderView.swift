//
//  MyInfoSectionHeaderView.swift
//  GraceLog
//
//  Created by 이상준 on 3/20/25.
//

import UIKit
import Then
import SnapKit

final class MyInfoSectionHeaderView: UITableViewHeaderFooterView {
    static let identifier = "MyInfoSectionHeaderView"
    
    private let titleLabel = UILabel().then {
        $0.textColor = .themeColor
        $0.font = UIFont(name: "Pretendard-Bold", size: 12)
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
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(40)
        }
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
