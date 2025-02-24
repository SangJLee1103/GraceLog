//
//  CommunityTableViewCell.swift
//  GraceLog
//
//  Created by 이상준 on 2/22/25.
//

import UIKit
import Then
import SnapKit

final class CommunityTableViewCell: UITableViewCell {
    static let identifier = "CommunityTableViewCell"
    
    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.alwaysBounceHorizontal = true
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    private lazy var communityButtons: [CommunityButton] = [
        createCommunityButton(image: UIImage(named: "community1"), title: "홀리바이블"),
        createCommunityButton(image: UIImage(named: "community2"), title: "새문교회"),
        createCommunityButton(image: UIImage(named: "community3"), title: "스튜디오306")
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        communityButtons.forEach {
            stackView.addArrangedSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
            $0.height.equalTo(130)
        }
    }
    
    private func createCommunityButton(image: UIImage?, title: String) -> CommunityButton {
        let button = CommunityButton()
        button.configure(image: image, title: title)
        return button
    }
}
