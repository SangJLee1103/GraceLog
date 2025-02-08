//
//  HomeNavBarTableViewCell.swift
//  GraceLog
//
//  Created by 이상준 on 2/8/25.
//

import UIKit
import Then
import SnapKit

final class HomeNavBarTableViewHeader: UIView {
    private let userButton = UIButton().then {
        $0.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        $0.setTitle("승렬", for: .normal)
        $0.setTitleColor(.themeColor, for: .normal)
    }
    
    private let userLineView = UIView().then {
        $0.backgroundColor = .themeColor
        $0.setHeight(2)
    }
    
    private let groupButton = UIButton().then {
        $0.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        $0.setTitle("공동체", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let groupLineView = UIView().then {
        $0.backgroundColor = .clear
        $0.setHeight(2)
    }
    
    private let bellButton = UIButton().then {
        $0.setImage(UIImage(named: "bell"), for: .normal)
        $0.tintColor = .black
        $0.setDimensions(width: 24, height: 24)
    }
    
    private let profileButton = UIButton().then {
        $0.backgroundColor = .systemGray2
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.setBackgroundImage(UIImage(named: "home_profile"), for: .normal)
        $0.setDimensions(width: 32, height: 32)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = UIColor(hex: 0xF4F4F4)
        
        let userButtonStack = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .center
        }
        userButtonStack.addArrangedSubview(userButton)
        userButtonStack.addArrangedSubview(userLineView)
        
        let groupButtonStack = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .center
        }
        groupButtonStack.addArrangedSubview(groupButton)
        groupButtonStack.addArrangedSubview(groupLineView)
        
        let rightStack = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.setHeight(32)
        }
        rightStack.addArrangedSubview(bellButton)
        rightStack.addArrangedSubview(profileButton)
        
        let mainStack = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 30
        }
        mainStack.addArrangedSubview(userButtonStack)
        mainStack.addArrangedSubview(groupButtonStack)
        
        addSubview(mainStack)
        addSubview(rightStack)
        
        mainStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        userLineView.snp.makeConstraints {
            $0.width.equalTo(userButton).offset(24)
            $0.centerX.equalTo(userButton)
        }
        
        groupLineView.snp.makeConstraints {
            $0.width.equalTo(groupButton).offset(24)
            $0.centerX.equalTo(groupButton)
        }
        
        rightStack.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
        
        bellButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
    }
    
    func toggleLines(isUserSelected: Bool) {
        userLineView.backgroundColor = isUserSelected ? .themeColor : .clear
        groupLineView.backgroundColor = isUserSelected ? .clear : .themeColor
        
        userButton.setTitleColor(isUserSelected ? .themeColor : .black, for: .normal)
        groupButton.setTitleColor(isUserSelected ? .black : .themeColor, for: .normal)
    }
}
