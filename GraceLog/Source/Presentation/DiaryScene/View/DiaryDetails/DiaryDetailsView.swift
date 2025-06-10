//
//  DiaryDetailsView.swift
//  GraceLog
//
//  Created by 이상준 on 6/8/25.
//

import UIKit
import Then
import SnapKit

final class DiaryDetailsView: UIView {
    private let backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = UIImage(named: "diary1")
    }
    
    private let gradientLayer = CAGradientLayer()
    
    private let contentView = UIView()
    
    private let containerView = UIView().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 20
    }
    
    private let categoryLabel = UILabel().then {
        $0.text = "오늘의 감사일기"
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Light", size: 16)
        $0.alpha = 0.8
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "스터디 카페에\n새로운 손님이?"
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Bold", size: 28)
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
        $0.setLineHeight(multiple: 0.95)
    }
    
    private let contentTextView = UITextView().then {
        $0.backgroundColor = .clear
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 16)
        $0.isEditable = false
        $0.isScrollEnabled = true
        $0.textContainer.lineFragmentPadding = 0
        $0.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 19)
        $0.verticalScrollIndicatorInsets = .zero
        
        $0.text = "처음에는 한숨만 나오고 절망을 느꼈다. 내 의지와는 상관없이 공간을 우리가 맡게 되었기 때문이다. 한 번도 사업을 해보지 않은 입장에서 시작하자니 막막했다. 많은 분들이 말씀해주셔서 무작정 시작했다. 예상한 것처럼 한 명도 오지를 않았다. 그러려니 했는데.. 갑자기 손님 한 분이 문을 열고 들어오신다. 속으로 외쳤다. “하나님 감사합니다!” 우리 스터디카페의 첫 시작이었다. 계속해서 손님들이 오는 건 아니었다. 다른 곳처럼 공사를 시작해서 오픈 한 것도 아니\n\n처음에는 한숨만 나오고 절망을 느꼈다. 내 의지와는 상관없이 공간을 우리가 맡게 되었기 때문이다. 한 번도 사업을 해보지 않은 입장에서 시작하자니 막막했다. 많은 분들이 말씀해주셔서 무작정 시작했다. 예상한 것처럼 한 명도 오지를 않았다. 그러려니 했는데.. 갑자기 손님 한 분이 문을 열고 들어오신다. 속으로 외쳤다. “하나님 감사합니다!” 우리 스터디카페의 첫 시작이었다. 계속해서 손님들이 오는 건 아니었다. 다른 곳처럼 공사를 시작해서 오픈 한 것도 아니\n\n처음에는 한숨만 나오고 절망을 느꼈다. 내 의지와는 상관없이 공간을 우리가 맡게 되었기 때문이다. 한 번도 사업을 해보지 않은 입장에서 시작하자니 막막했다. 많은 분들이 말씀해주셔서 무작정 시작했다. 예상한 것처럼 한 명도 오지를 않았다. 그러려니 했는데.. 갑자기 손님 한 분이 문을 열고 들어오신다. 속으로 외쳤다. “하나님 감사합니다!” 우리 스터디카페의 첫 시작이었다. 계속해서 손님들이 오는 건 아니었다. 다른 곳처럼 공사를 시작해서 오픈 한 것도 아니"
        
        $0.setLineHeight(multiple: 1.26)
    }
    
    private let bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 59
    }
    
    private let moreImageView = UIImageView().then {
        $0.image = UIImage(named: "diary_more")
        $0.setDimensions(width: 24, height: 24)
    }
    
    private let likeButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "diary_heart")
        config.title = "24"
        config.baseForegroundColor = .white
        config.imagePlacement = .top
        config.imagePadding = 7
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "Pretendard-SemiBold", size: 14)
            return outgoing
        }
        $0.configuration = config
        $0.tintColor = .white
    }
    
    private let commentButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "diary_message")
        config.title = "9"
        config.baseForegroundColor = .white
        config.imagePlacement = .top
        config.imagePadding = 7
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "Pretendard-SemiBold", size: 14)
            return outgoing
        }
        $0.configuration = config
        $0.tintColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }
    
    private func configureUI() {
        layer.cornerRadius = 20
        clipsToBounds = true
        
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundImageView.layer.addSublayer(gradientLayer)
        
        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.height.equalToSuperview()
        }
        
        contentView.addSubview(moreImageView)
        moreImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().inset(17)
        }
        
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().inset(48)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().inset(48)
        }
        
        contentView.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(47)
            $0.bottom.equalToSuperview().inset(29)
        }
        
        [likeButton, commentButton].forEach {
            bottomStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().inset(28)
            $0.bottom.equalTo(bottomStackView.snp.top).offset(-22)
        }
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(
            CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0)
        )
    }
    
    private func updateGradientFrame() {
        gradientLayer.bounds = bounds.insetBy(
            dx: -0.5 * bounds.size.width,
            dy: -0.5 * bounds.size.height
        )
        gradientLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    func configure(with diaryItem: MyDiaryItem) {
        titleLabel.text = diaryItem.title
        contentTextView.text = diaryItem.desc
        
        backgroundImageView.image = UIImage(named: "diary1")
    }
    
    func configure(title: String, content: String, backgroundImage: UIImage?, likes: Int = 24, comments: Int = 9) {
        titleLabel.text = title
        contentTextView.text = content
        backgroundImageView.image = backgroundImage
        
        likeButton.setTitle("\(likes)", for: .normal)
        commentButton.setTitle("\(comments)", for: .normal)
    }
}
