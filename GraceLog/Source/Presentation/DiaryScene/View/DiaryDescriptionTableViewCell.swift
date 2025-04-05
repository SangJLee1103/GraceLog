//
//  DiaryDescriptionTableViewCell.swift
//  GraceLog
//
//  Created by 이상준 on 3/26/25.
//

import UIKit
import Then
import SnapKit
import UITextView_Placeholder

final class DiaryDescriptionTableViewCell: UITableViewCell {
    static let identifier = "DiaryDescriptionTableViewCell"
    
    private let descriptionTextView = UITextView().then {
        $0.backgroundColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .black
        $0.placeholder = "오늘은 하나님께 어떤 점이 감사했나요?"
        $0.placeholderColor = .gray200
        $0.textContainerInset = UIEdgeInsets(top: 11, left: 15, bottom: 11, right: 15)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray200.cgColor
        $0.layer.cornerRadius = 10
        $0.returnKeyType = .done
        $0.isScrollEnabled = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(29)
            $0.height.equalTo(contentView.snp.width).multipliedBy(355.0/334.0)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
