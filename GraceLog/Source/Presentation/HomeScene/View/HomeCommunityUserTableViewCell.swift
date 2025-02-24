//
//  HomeCommunityUserTableViewCell.swift
//  GraceLog
//
//  Created by 이상준 on 2/24/25.
//

import UIKit
import SnapKit
import Then

final class HomeCommunityUserTableViewCell: UITableViewCell {
    static let identifier = "HomeCommunityUserTableViewCell"
    
    private let profileImgView = UIImageView().then {
        $0.setDimensions(width: 40, height: 40)
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .graceLightGray
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    private let usernameLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 12)
        $0.textColor = .graceGray
    }
    
    private let diaryCardView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    private let cardImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let overlayView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 20)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    private let hashtagsLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Light", size: 11)
        $0.textColor = .white
    }
    
    private let likeButton = UIButton().then {
        $0.setImage(UIImage(named: "heart"), for: .normal)
        $0.setTitle("4", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 14)
    }
    
    private let commentButton = UIButton().then {
        $0.setImage(UIImage(named: "comment"), for: .normal)
        $0.setTitle("4", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 14)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        let userStack = UIStackView(arrangedSubviews: [profileImgView, usernameLabel])
        userStack.axis = .vertical
        userStack.spacing = 4
        userStack.alignment = .center
        
        let contentStack = UIStackView(arrangedSubviews: [titleLabel, hashtagsLabel])
        contentStack.axis = .vertical
        contentStack.spacing = 4
        contentStack.alignment = .leading
        
        let interactionStack = UIStackView(arrangedSubviews: [likeButton, commentButton])
        interactionStack.axis = .horizontal
        interactionStack.spacing = 8
        interactionStack.distribution = .fillEqually
        
        [userStack, diaryCardView, interactionStack].forEach {
            contentView.addSubview($0)
        }
        
        [cardImageView, overlayView].forEach {
            diaryCardView.addSubview($0)
        }
        
        overlayView.addSubview(contentStack)
        
        userStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(21)
        }
        
        diaryCardView.snp.makeConstraints {
            $0.leading.equalTo(userStack.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(diaryCardView.snp.width).multipliedBy(110/300)
        }
        
        cardImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(37)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalTo(29)
        }
        
        interactionStack.snp.makeConstraints {
            $0.top.equalTo(diaryCardView.snp.bottom).offset(8)
            $0.leading.equalTo(diaryCardView.snp.leading).offset(23)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
