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
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let containerView = UIView().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 20
    }
    
    private let categoryLabel = UILabel().then {
        $0.text = "오늘의 감사일기"
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 16)
        $0.alpha = 0.8
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "스터디 카페에\n새로운 손님이?"
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Bold", size: 28)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    private let contentTextView = UITextView().then {
        $0.backgroundColor = .clear
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 16)
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.textContainer.lineFragmentPadding = 0
        $0.textContainerInset = .zero
        $0.text = "처음에는 한숨만 나오고 절망을 느꼈다. 내 의지와는 상관없이 공간을 우리가 맡게 되었기 때문이다. 한 번도 사업을 해보지 않은 입장에서 시작하자니 막막했다. 많은 분들이 말씀해주셔서 무작정 시작했다. 예상한 것처럼 한 명도 오지를 않았다. 그러려니 했는데.. 갑자기 손님 한 분이 문을 열고 들어오신다. 속으로 외쳤다. “하나님 감사합니다!” 우리 스터디카페의 첫 시작이었다. 계속해서 손님들이 오는 건 아니었다. 다른 곳처럼 공사를 시작해서 오픈 한 것도 아니"
    }
    
    private let bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 59
    }
    
    private let likeButton = UIButton().then {
        $0.setImage(UIImage(named: "diary_heart"), for: .normal)
        $0.setTitle("24", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        $0.tintColor = .white
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private let commentButton = UIButton().then {
        $0.setImage(UIImage(named: "diary_message"), for: .normal)
        $0.setTitle("9", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        $0.tintColor = .white
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
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
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        contentView.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(47)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        bottomStackView.addSubview(likeButton)
        likeButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        bottomStackView.addSubview(commentButton)
        commentButton.snp.makeConstraints {
            $0.leading.equalTo(likeButton.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(40)
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
