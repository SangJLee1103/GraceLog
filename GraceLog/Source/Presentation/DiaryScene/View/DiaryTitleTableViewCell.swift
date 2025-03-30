//
//  DiaryTitleTableViewCell.swift
//  GraceLog
//
//  Created by 이상준 on 3/25/25.
//

import UIKit
import Then
import SnapKit

final class DiaryTitleTableViewCell: UITableViewCell {
    static let identifier = "DiaryTitleTableViewCell"
    
    private let titleField = UITextField().then {
        $0.setHeight(40)
        $0.font = UIFont(name: "Pretendard-Regular", size: 16)
        $0.placeholder = "일기 제목"
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray200.cgColor
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(titleField)
        titleField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(29)
            $0.bottom.equalToSuperview().inset(22)
        }
    }
}
