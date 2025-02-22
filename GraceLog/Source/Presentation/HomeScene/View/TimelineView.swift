//
//  TimeLineView.swift
//  GraceLog
//
//  Created by 이상준 on 2/17/25.
//

import UIKit

final class TimelineView: UIView {
    private let lineView = UIView().then {
        $0.backgroundColor = .themeColor
    }
    
    private let dateLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 12)
        $0.textColor = .themeColor
        $0.numberOfLines = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI() {
        lineView.snp.makeConstraints {
            $0.width.equalTo(2)
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(lineView.snp.leading).offset(-8)
        }
    }
    
    func configure(date: String) {
        dateLabel.text = date
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
