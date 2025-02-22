//
//  DiaryCardView.swift
//  GraceLog
//
//  Created by 이상준 on 2/16/25.
//

import UIKit

final class DiaryCardView: UIView {
    enum Style {
        case latest
        case past
    }
    
    private let style: Style
    private let item: DiaryItem
    
    private let contentView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(hex: 0xF4F4F4)
    }
    
    private let overlayView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    private let dateDescLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Light", size: 11)
        $0.textColor = .white
    }
    
    private lazy var subtitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Bold", size: 32)
        $0.numberOfLines = 0
    }
    
    private lazy var tagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    init(style: Style, item: DiaryItem) {
        self.style = style
        self.item = item
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        setupBasicUI()
        setupLayout()
    }
    
    private func setupBasicUI() {
        imageView.image = item.image
        
        titleLabel.text = item.title
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: style == .latest ? 14 : 20)
        
        dateDescLabel.text = item.dateDesc
        
        switch style {
        case .latest:
            setupLatestUI()
        default:
            break
        }
    }
    
    private func setupLatestUI() {
        subtitleLabel.text = item.subtitle
        setupTagStack()
    }
    
    private func setupTagStack() {
        item.tags.forEach { tag in
            let tagLabel = UILabel().then {
                $0.text = tag
                $0.font = UIFont(name: "Pretendard-Regular", size: 14)
                $0.textColor = .white
            }
            tagStackView.addArrangedSubview(tagLabel)
        }
    }
    
    private func setupLayout() {
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(overlayView)
        
        [titleLabel, dateDescLabel].forEach {
            overlayView.addSubview($0)
        }
        
        if style == .latest {
            [subtitleLabel, tagStackView].forEach {
                overlayView.addSubview($0)
            }
        }
    }
    
    private func setupConstraints() {
        setupBaseConstraints()
        
        switch style {
        case .latest:
            setupLatestConstraints()
        case .past:
            setupPastConstraints()
        }
    }
    
    private func setupBaseConstraints() {
        let screenWidth = UIScreen.main.bounds.width - 97
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.width.equalTo(screenWidth).priority(.high)
            $0.height.equalTo(screenWidth * (style == .latest ? 1.0 : 11.0/30.0)).priority(.high)
        }
    }
    
    private func setupLatestConstraints() {
        dateDescLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(18)
            $0.leading.trailing.equalTo(contentView).inset(21)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateDescLabel.snp.bottom)
            $0.leading.trailing.equalTo(contentView).inset(21)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).inset(21)
            $0.centerY.equalTo(contentView)
        }
        
        tagStackView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            $0.leading.equalTo(contentView).offset(21)
            $0.bottom.lessThanOrEqualTo(contentView).offset(-21)
        }
    }
    
    private func setupPastConstraints() {
        dateDescLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(32)
            $0.leading.trailing.equalTo(contentView).inset(26)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateDescLabel.snp.bottom)
            $0.leading.trailing.equalTo(contentView).inset(25)
            $0.bottom.lessThanOrEqualTo(contentView).offset(-21)
        }
    }
}
