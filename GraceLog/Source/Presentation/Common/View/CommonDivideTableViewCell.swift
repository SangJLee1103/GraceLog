//
//  CommonDivideTableViewCell.swift
//  GraceLog
//
//  Created by 이상준 on 4/5/25.
//

import UIKit
import SnapKit
import Then

final class CommonDivideTableViewCell: UITableViewCell {
    static let identifier = "CommonDivideTableViewCell"
    
    private let divideView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(divideView)
        divideView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setUI(left: CGFloat = 16, right: CGFloat = 16, height: CGFloat = 1, color: UIColor = .gray200) {
        divideView.backgroundColor = color
        
        divideView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(left)
            $0.trailing.equalToSuperview().inset(right)
        }
    }
}
