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
        $0.distribution = .fillEqually
    }
    
    private lazy var communityButtons: [CommunityButton] = []
    
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
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(140)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.leading.equalToSuperview().inset(17)
            $0.trailing.equalToSuperview().inset(17)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func createCommunityButton(image: UIImage?, title: String) -> CommunityButton {
        let button = CommunityButton()
        button.configure(image: image, title: title)
        return button
    }
    
    func configure(with buttons: [CommunityButtonModel]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        communityButtons.removeAll()
        
        buttons.forEach { buttonModel in
            print(buttonModel)
            let buttonView = createCommunityButton(image: UIImage(named: buttonModel.imageName),
                                                   title: buttonModel.title)
            communityButtons.append(buttonView)
            stackView.addArrangedSubview(buttonView)
        }
    }
}
